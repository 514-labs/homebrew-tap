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
  version "0.5.163-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.163-rp/aarch64-apple-darwin/ax"
      sha256 "825d57148a0f8844db9560f2f0d07ca3570a3f695f9f8f1795d3c6a899c0440b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.163-rp/x86_64-apple-darwin/ax"
      sha256 "8c750ceb8dd0d6cbf35825b95378db0364ef9d09a94e005d2051e8a1298858d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.163-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "ab4d5f5cb6ca2290260635cda20b546de7fcf6a00d685af6fb6fb9735463459f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.163-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "6bdd4194ec62e41e88b229e6de044fe6eb201225e1cb9dc393d45bf8afde0032"
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
