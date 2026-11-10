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
  version "0.5.1709-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1709-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fee0f7a5b8b556b4ed4ea0c75c907b60fa93561c1a334909b6bbbbcee26b6f6b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1709-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "eac9f287942aacdf4572885cc7295beb93cbfd129489ee66cdd56a877b00196d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1709-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fc8757bc89959e4a2b94e920f28fb40f15bb014549fa5bc7331891021480e6e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1709-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "79b7d176cae0f5da9aac7e258acdfba837271d78057643e6a09b7c791399638b"
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
