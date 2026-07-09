# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.140-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.140-rp/aarch64-apple-darwin/axp"
      sha256 "d939bcdf0ca5fd7a3cea0f28ec963e3c017a2d1c09eae15d5dd36dada43c5cb3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.140-rp/x86_64-apple-darwin/axp"
      sha256 "38ddba0196a0352a67c69f2806f0e8023a68f2436093579e9118c04517a65037"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.140-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "96ded6223b091357b69e047ee1cc37158c177fd41fe06e8ad1ac39054e29b51d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.140-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e11c6e5679d269ab8afd2194afa10e6a2c93bc7fa2acc37fa57bf4ed38ee539c"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `axp` (the CDN object's basename); put it on PATH.
    bin.install "axp"
  end

  def caveats
    <<~EOS
      Install MCP:
          https://docs.514.ax/docs/mcp-install

      Request access / sign up:
          https://app.514.ax/sign-up
          The AXP platform is currently in closed alpha.

      Sign in:
          https://app.514.ax/sign-in
          axp auth login --token <token>

      Author intro experiment (CLI install test experiment):
          axp intro <name> --cli <cli> --target-description '<description>' --install-docs <url> --install-command '<cmd>' --smoke-command '<cmd>'
          axp auth login --token <token> → axp experiment validate <experiment.yaml>
          axp run [--variant <id>] [--repeat <n>] <experiment.yaml>
          axp query "SHOW TABLES" --table

      Docs:
          https://docs.514.ax/docs/getting-started
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
