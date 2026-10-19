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
  version "0.5.1424-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1424-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bbfc5e1d826ac9ee1f6e4a0cf58cbbb4c45bbc254fac2c6a4bc9d637d199dcd9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1424-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4ea8b0b3f3cc28b860a8cb827d65b280025e7cca3c02772210bf1e61e508e3c4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1424-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2323e5cd2be52605209f55b9933940fb5b7db9676954d4cd9a41719e59bb3aac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1424-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "697b25c825037951c974ec06dbaf12d65c5fdbecc536a149b9067ec6598d1f35"
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
