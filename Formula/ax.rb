# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.826-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.826-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b70cccf2c04cb5e001ef422569f9c7a9b51e7d4738381d7a4d8fe672f120dbe3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.826-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cf5d73a41887bfd2197fed6d7c82ce7495fe0b0ba59ffc3cffa50f36583c7f15"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.826-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9944598a5921c2a5ba23dbe693583425d1ae24b0f342964c6d8202e681b2bb9a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.826-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a91170ea3d6506e98fc0f90656f78985d0f4e2a89e2e5b0c0c4acec9280e9108"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
