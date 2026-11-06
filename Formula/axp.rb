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
  version "0.5.1667-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1667-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8d8fbaec2d69a0324a120529d25b3e38816a7e26823a52e6bc9e2673db14eaeb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1667-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "425be45c59c604a8d9a5464d3cb76b6d22fa57f023b473c99fc5ff2a772ac21e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1667-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7c2711db929e3fdeb56197ef7e1af421a2c5d6466a8705f55cd98a95653abad1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1667-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "851477ccdf3aace78ea12617faeecc237e017167b05e10ff4a6010bc88a78b71"
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
