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
  version "0.5.1790-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1790-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cbdb711820a02cdb163231c95aa8214299e2716b3acadab966b8d3e54584fcab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1790-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8b86b30fa4eb5de2fd06ba8b3ee6a1deb948075b816cc34a33e737ffa9e9b2b0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1790-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fb6cae4cb9c9a6570bf4980d30ceb9bb9b3b33c0f0bc7b62dbcdcfb92e972c62"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1790-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6716587ca18e9ad770aba1534a32e28658b241b99569dcf70a5a2523689759ac"
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
