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
  version "0.5.1690-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1690-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c00cfff8f9ff476c1f007b702973eda2fe5ef03be8e75f469f6629f175952a16"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1690-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ac2e5f120f945eacd8d93f67ada7dc64fa0b6ab89305ba46bacbecd5eb9b7e0f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1690-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1914c084bb6622b40b689dbe4c269921d84649befff2fd94c2f5826002e07947"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1690-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c634a3c51a44b115105d14ca81fd95bc3eb6b04e5d0b6294ca183209a6c47d93"
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
