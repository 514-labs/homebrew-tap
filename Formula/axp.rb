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
  version "0.5.1396-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1396-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "da113c74a0437e5d33677b0f6cd9cbb88b9cab76c572d279ae94057bd617b987"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1396-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "47566c42fad1067cd335d603df3622ea2db187f36190d4709eacbeefad4f06e7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1396-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "aa55c94c8571431d1914840af4afb81e9d593389884c4401cace1620e31f070c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1396-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9470be5c4b9c7b9aa62adb82e31867e789707d3d6a15685f4d584efab4d20589"
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
