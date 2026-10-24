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
  version "0.5.1486-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1486-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4e68eb51ed30780d607f6d3a2acfb9e34b6658ba19b1261f946e8d9657525ac0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1486-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0ba3a70a1b0444901814a9a0d6812cc9a845e4085dd5cb8b87f164d47c7c3449"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1486-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a8d2082522092b0c35649980ad15ec98262ac411a91afa7c03dd6365b818d336"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1486-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "321d1e610fa02f567f172a5155dcc617cca3a52e8bcf315ab66d9953d0295e26"
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
