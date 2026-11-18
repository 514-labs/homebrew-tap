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
  version "0.5.1752-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1752-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f9cd0077b19c3a620f7b5ddf40f26d3968c4eb4c06922029e0022b26400f645a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1752-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "94375d8b26ebd58b83eef3bf524ef4d000ae900ac21dc913e66cd42ef9abb532"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1752-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8f254ef2cfa3112c1feb4b57e8759c987755facdaefa453367b0dbf31436d6f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1752-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6dc795065b5c45660a02dc4662839374f17a086ee7a5c82408a0f0c7cf891de2"
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
