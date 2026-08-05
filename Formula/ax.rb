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
  version "0.5.657-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.657-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f8ea034b6cab1109e09ffb598de318e2e6f5f15917af95a4fa7ab0bfa263a7bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.657-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6154a74b30add7d8c379ab638b9e2aa34b47de5983d0af51bf86f4c54eab84f3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.657-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0852166515bf1bbd41648b3553d1c6ace281861ef2ce2fe1deb7a8a767f5d548"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.657-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c090e4b6b5e82c8886457dc772051a4388223afd01e134e18a0b558914deb790"
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
