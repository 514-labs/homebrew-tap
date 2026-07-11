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
  version "0.5.159-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.159-rp/aarch64-apple-darwin/axp"
      sha256 "0fcb490b7b055206897b161b8db02da54a30c0240a5a77f71b607d929f251aaa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.159-rp/x86_64-apple-darwin/axp"
      sha256 "cf25cf7b2805c1732a5f6f5e1b0d0f3c4da75cc277d457f6624f8e896dfc0ece"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.159-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "20459d485ca3119a41caf77af636f633957b7f6dca7640e7b4a40cb8349218bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.159-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "32f7781f7d06568de38003bdf8a07897a1a318a2c78318a5c9a3948eb5a13235"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
