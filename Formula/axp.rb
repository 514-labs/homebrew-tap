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
  version "0.5.1801-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1801-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "71a9b66cfbe47eadb0bc118e3b08399e7126f0b5420e22f636300b25812aed2d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1801-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f8a003b318727076d44bb449d8ab3f4e940a15c4819c95ea4dc6a7b92b5ffce1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1801-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7416b30c2a0ea236a82e44f3a4830edc64505477125c1526b75755965d498099"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1801-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f25a80bfd823307442b37acddaae09cbcf398196f9304bab8596765f96aad6b7"
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
