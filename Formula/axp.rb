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
  version "0.5.1251-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1251-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "424fc99b5b0e84a37b7152d3fa729ad404288f59a93fb35ab709efb5cae4318a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1251-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5936ca25043304e0c361eca32d1427433327a083ab562ced03c131d9565e432e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1251-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "21bc610ec8c04f7ad902fe05b6466aa9b45071389265791037c27ab43ddcd7b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1251-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4e4cd5bc81b3ee9811696e08513295fb64da6e2d0bbac2ecfc58f3bdcbe51dbb"
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
