# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1415-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1415-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "abbb100e4898d74f0bc3a51addecb2f6510228665550eacfec0ef2db77f9e4e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1415-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f6d82d4664c2a49c78d172c279c1d88354930cab9ad788b7667b1f04298f8e67"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1415-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7d3ed8c2f20dc007b701e2eeed498faa2b10ec88e50c648e53162b7b88b1c660"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1415-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5d707f4ea5f13714a3dd4bb78c6e11f10596ddedf8bbbd504ebf21cb1786232a"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
