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
  version "0.5.120-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.120-rp/aarch64-apple-darwin/axp"
      sha256 "836592c4cc42366d8e7d7c50767a43f32781fe0dcfc0dafac83a8ac0dba9c68a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.120-rp/x86_64-apple-darwin/axp"
      sha256 "2e87a7a3a269bb1535e04e143e9ef9243a44ed246f5a0e47465ca35b0b1c1661"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.120-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "d023d1a0955d38db425f1db7d4a0e635b4e320b94a46b4a22f2bf47e45172a83"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.120-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "3f5d3098fb83f293c299f867181d80518f9a72c4b9e7d87a8bb14b9d377bde80"
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
