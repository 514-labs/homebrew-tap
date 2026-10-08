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
  version "0.5.1285-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1285-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "903387534d3a258af3608043748fcfa1a2d5ce96211129a5de76ef1d978c7386"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1285-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "48dd8acebde075a8cd135092f12cb565dbf49bdb4722e201f3fa9cf69b495096"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1285-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5b5f8daed0171f0b0483db7b642757062e7a826c0554d4e12f2153115d81f239"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1285-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c97fa93520b0f3cd65410da531b46ec13831a1759ec95bf9726fad8360ab872e"
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
