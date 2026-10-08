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
  version "0.5.1285-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1285-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5c58277e0cb082ecc60c59ddc7b6f0394f4e1bdf501931689305c3d99443e78e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1285-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d65f6193e662a5d50898c8e4fadc6f41bda025e739f48c4d7c37b40e1051a4f0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1285-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a6fa6ec1f0f55e9e46663ccd987af2f8d46f5e445c1c6509fa153368a9ea7e37"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1285-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4204a5c12dcaa70bfaa0b4dbc188bac87633909ef523f60bebcb678b87708bef"
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
