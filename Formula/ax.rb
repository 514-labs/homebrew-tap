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
  version "0.5.1350-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1350-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7c981ebf975aae072c2b2ccade9aca5ce63e408f19cb29f47eb9fda389e7f0f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1350-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8191ef82f19b88a031a2b7c7c2e1b4ea930b67364c321facf982ddee060f22cf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1350-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6dc104fb3a0651463846cea0b1428fa1141d3658bc24f39c76a0e925a159fdfa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1350-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d814c373eec66b34cacc05185293580a442950d7b4bfa8a263ed9e2ee84dafcb"
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
