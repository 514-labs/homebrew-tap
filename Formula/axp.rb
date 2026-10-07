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
  version "0.5.1271-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1271-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "279b551ce9a1eb21a0b6bd0a3f3fc63c2a82c9737a7241373d0b820526c23a6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1271-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ff8af5188f82588c792cfe65503b71f9eb23251eb1a7f4f2d2654b474dc56a27"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1271-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a6bedaca07251c134fcec052c02738337f0dcd179c561f034e04c9dc65ebc8e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1271-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3cd11cbef939795fb9bd7fd3c7b96b83f944937bf011b2b2517f35d7957fe5e8"
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
