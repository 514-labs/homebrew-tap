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
  version "0.5.1255-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1255-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8473b02b9ebb94938b03013a62856b5a2873f59a54eabc67c6c68b6e62187ec3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1255-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f2cb6487c287458c59e562a59894f6adef5e3c4a1cebe1d2dff1009808cbde9b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1255-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8b515c402c619e0f0941d21ae7dee606637ae3e9ec317577703226fb6177b854"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1255-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "18db8943a3ed5f97affc43ca1d7a8795d78826bc07371378f443ad11e8377291"
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
