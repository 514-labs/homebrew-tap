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
  version "0.5.1402-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1402-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a0456fb4991a789ee56d9c270601ef45bb5a82e06de3f2b426e57665926c5541"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1402-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d6f5e92099af4afe511427de9db8674f084fed4a37dd37e66c9c22caab7732dd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1402-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f01b2480d0ba4595fb494a984d07f86ef3749c8d06c794354d32c0d9831fa8de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1402-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2f1aeb1e02a6678ecd10af158d24073e553fbee5b82c619afe3a8bf9a4f2fda9"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
