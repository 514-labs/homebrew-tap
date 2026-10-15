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
  version "0.5.1362-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1362-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "398b8a9862599321bfa53fc403ea760d14a37a9a80667b9025b447fe88ffeabf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1362-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9066eeed1ac969c56cef8adb9a28f836429f3d0787fc04028001e67d17fadb3b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1362-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1f49d091db6b598468b0273f3e84996321ac43da988e55d6e916736be155beff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1362-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8f2c12b65de75135fc65e5fa4a342e84ee963eb61c24c7fe520b1912ce77be03"
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
