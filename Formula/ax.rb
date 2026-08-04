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
  version "0.5.638-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.638-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d6617948b1344f30304f1df455fbdaa375fefcf6e9296c6a97594bb3d20f7356"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.638-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "35c17eac44c9cd3b5ec5753492e1c8dd8ee0d6a763853b91a51e50e2441bc72a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.638-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "96bec007d8f1305187a0c55968750c22b55650d84be8ec6e3d123e8d2ddb40de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.638-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "96c00488db46b1292beaeb02d96ab88e39767c8b9e8ddb83b00876271926908b"
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
