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
  version "0.5.1795-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1795-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4a2c9661d88453b9df581dcc711b24ef06892777fa1849150b9a1fb3ec03f024"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1795-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "238f6990cb82db809e73f27d43c6fabf1b51004e8d1bbcd5d67405b904906d86"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1795-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4ddd9ee825d0b337627819edc9a6fb41a251c40435403b7879c5b3507fdd97f7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1795-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec8d114f8ac5160ac0f67207a2aee36c900aad546e334fa3549182aae7ad664c"
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
