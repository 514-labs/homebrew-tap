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
  version "0.5.128-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.128-rp/aarch64-apple-darwin/axp"
      sha256 "369c02c872913e8b1e89bf90170f52b97651978e2afad90b0ff4d4adccc5c179"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.128-rp/x86_64-apple-darwin/axp"
      sha256 "bf1fc7b55a8ee66da0daa94fd1196445f58cbbcd569be0fb7a65ed9587d16d3f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.128-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "112aac1d9fcd445b050c3a80ccd746310f1aded4d1406fe6ad0c0aabf2d22f1f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.128-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "8659e2d0f68a4d6a209ea5d63645fa12f1c3fa084f168d6a988590669d127f9a"
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
