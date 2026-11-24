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
  version "0.5.1788-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1788-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "54c24fe97be2238cfdf3efa2493a70914b7387689de193915b432bfad5e5773e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1788-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1ce0f1f89892a1a2cf91097797a309eba2cfe618d43e1cec7557bf46e12caa02"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1788-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "25a3499540c827f338e284d879d18328ffbb95fdf415149bcd17a6465325e63e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1788-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ba6ca4bdc06c2ee33e82b67e9348cfebd332a055b017382c62576d37c2ae8bb"
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
