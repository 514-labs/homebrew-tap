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
  version "0.5.151-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.151-rp/aarch64-apple-darwin/ax"
      sha256 "91f276f26d48d2d34612647dc7747e13543e1ed239a92aa0c541b892178197c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.151-rp/x86_64-apple-darwin/ax"
      sha256 "e1b750bd1bcc6e37f11109b2e0892fd66d2f11353fae212089d1eb90d1709ebb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.151-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "b7e8420f051c618d1ed260d09c646fe29b4082af267e58da23d704eab1d1fe66"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.151-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "937dd8438537252bf137b54fe3928d885e4c41a34c7417a8eaf9e20952a77d30"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `ax` (the CDN object's basename); put it on PATH.
    bin.install "ax"
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
          ax auth login --token <token>

      Author intro experiment (CLI install test experiment):
          ax intro <name> --cli <cli> --target-description '<description>' --install-docs <url> --install-command '<cmd>' --smoke-command '<cmd>'
          ax auth login --token <token> → ax experiment validate <experiment.yaml>
          ax run [--variant <id>] [--repeat <n>] <experiment.yaml>
          ax query "SHOW TABLES" --table

      Docs:
          https://docs.514.ax/docs/getting-started
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
