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
  version "0.5.814-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.814-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "70229f9e9c1ddbb6e17f41123df50836774de22695cfce2054c5c475a6282f2e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.814-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0c331827028a36033a6068b0b3ee80862c2885d6f8190979577fa754631cf0da"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.814-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a665e6c7675f935181b3fc42b1556bcdef918bb459064a45e269f8b686b260a7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.814-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a5e8c95f33a984a05a313883a2cf8a438fc6b33088d23faecfa34e654d3f96ef"
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
