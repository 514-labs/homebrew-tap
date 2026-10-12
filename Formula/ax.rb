# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1328-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1328-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "af6d2b36e407d6dac0a484c42213a187595db428c72daa9daa71ca4c825f14e2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1328-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b7bb76e8401fb871ea75f6710b20d80f9cd5473dc4020372051dfef9047f4594"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1328-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5e5b75fc45c4912900f9efefc48d3b04a5de37686dab1631839f2ddcafaf6c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1328-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "338665566f56555454a4dbc312927117abf1e2b2fdaa321f2566ffca27cb9601"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
