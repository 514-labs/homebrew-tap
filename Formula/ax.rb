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
  version "0.5.1729-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1729-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "871b777413b3b5b0f63a65683b10701fec56c73e68304246c279e5f817256ee9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1729-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "88174e5827f2eef8c5db17dfdff3fed006b174f4bcb902b14584856deec187b7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1729-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b7aebeea9a1042887670a2e4c30d30cfdf24a8628f25546bd68d78535683262"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1729-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "901b00d7d5a492bfa6b9ea3967bea2272c9a59ae351505bf5e3177940551c73f"
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
