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
  version "0.5.229-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.229-rp/aarch64-apple-darwin/ax"
      sha256 "470c440e35bd01d8c947ce6f1d9062d0b2e7f8767b709091fef316257eeeaf17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.229-rp/x86_64-apple-darwin/ax"
      sha256 "e62cba8a3c518038c121d2d014b9293a489c15629412d804cf8f5b208a437f43"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.229-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "437a1df24d19e71e966320bbb17d44be1106911907a837c6593466d00221a583"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.229-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "af42fe1ff0875c11aaa73314a4afd4aecdc2a087fb6e8e5d7d1fed07d5b50dad"
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
