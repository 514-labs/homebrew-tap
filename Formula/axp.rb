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
  version "0.5.1309-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1309-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a90d3568abf8c274de5c58ba0b26c247bafa4e7174042c05a1dabc91b03f1573"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1309-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e19f8c4037e7eb17654155764efa02737a60d55096f6b06c9ba6e97702f4dd3a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1309-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db2f80477d534fb953a8efe7a2b96b7b5496e99876f4ab2285906823223fc2cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1309-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "455b157f92ba8c5154886a815157b5eabe1842c2106d0bf51986346befddf7d0"
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
