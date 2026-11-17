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
  version "0.5.1742-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1742-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "14790a1e855752c0eb496e217029ca417603fe228a5fba7b772d70f975569e8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1742-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7f5a14bee7b245ad33553b5b20173ecd07e23a7cd0de3e7ca56c21c2f55e59dd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1742-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "79dfbb9fa8f39a9458b6587b0e42f94959b425b2c5c3db7167df59190e885526"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1742-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ff2edd43be69fa494ec29dcab58b1fc8482b4fc88409e0f4c663188f927f23a9"
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
