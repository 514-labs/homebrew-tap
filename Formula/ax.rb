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
  version "0.5.1465-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1465-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c0a1695547f59ce661c8112320cb61233ad9b130de786377d15f478950f9a9d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1465-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b11c61f6fcce55ce1fa5058e1ea05d68e1b6703aa5aa5d2a08d776cb592e9196"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1465-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e161caeba1dbb8e4651dc741a614712787bc65caba22022db5f24c3fc8848ebc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1465-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1b9eff1c3f5050bff7b79144c70b8b8cd9ae3908dd4536099bd052426e238924"
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
