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
  version "0.5.1272-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1272-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "52a7a82ac37886f018305c4ca398d6682ad8d8da08238e6959620e11f152b865"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1272-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "507b897a38f72725ac479a29b4abfbee392aff12b919d25f0afce2160d931f46"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1272-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "78a47c6d79b33dec681c5370582d99b9d25648da59a282b4191dec4ac569de86"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1272-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3f90c5fd2af3e61925b5845e743eab1a056098bd4f3e92331294fa5c13db48e0"
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
