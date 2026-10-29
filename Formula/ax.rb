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
  version "0.5.1543-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1543-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "28c2cf0a3ee6ccea1bbe6271e4904767e18a4e6d49715fee6a20603e0516ce38"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1543-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "43eb8daff51fede9744e1cc8309c6f476c84ba7982a0a1e78b221335a3faa8da"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1543-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1d1de274c7e3cdaee885a333fe0f8a8488c37332a6765c76b9732ecb16248379"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1543-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "832195a57d79b13d666d3111356d9c6feb0f7f8843d36dc663136d6958e0643b"
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
