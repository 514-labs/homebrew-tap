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
  version "0.5.1723-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1723-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cea1809ef7b3fe607a50cc93e312dd6dae7bfaf3004aa9eb497827f8443fc891"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1723-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "af9c6136e8279f5ccdd81aa8f76c98861b72f407924cb94e7e48ea2629c33ecb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1723-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6256eab0fd22f533bb8914964df9af33c617c87f1e8e96b7e032b24671a5aaed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1723-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ab745ac43a3babd48c009e67241f924d423bce6d51b95c02ad499c527e3026da"
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
