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
  version "0.5.1782-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1782-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "eb6893edbcdc4c81967e32afed68a18e14a74b2c825333b5bbb43e336ca34275"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1782-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4891b785df30b22e322fc665f72482cfa9b0ab21af5289d4954328feba845dd6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1782-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0f88f5f600d1c88db50607a7eab7cb6bd8e376097cf7bcbbab06cfa27025d56a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1782-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "075c2dbdc3353ce9243e9565cb146b5708335c5e1dc760fc470a910f14d366d7"
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
