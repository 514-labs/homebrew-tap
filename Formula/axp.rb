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
  version "0.5.1333-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1333-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9b4f2f2e59de8af55a797d28e4767ceceecaab1fe97f69657ddf844b1c6f8c49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1333-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b283152d17c7e877bb6e691f5c600637919fcf8d8d4dab16b93ba146014b9e8c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1333-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7e86f4a558318f8f50ce41b66a16fb9f83b320edc985581658545efaf2a6a153"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1333-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "df4b4390d849f8d62b4edd7fb51f7d2ef4008d3898b95ad70d760863a1ff59a8"
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
