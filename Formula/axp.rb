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
  version "0.5.144-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.144-rp/aarch64-apple-darwin/axp"
      sha256 "90406e3ba9b6fe45b78d5a10cb95b8132c729ffde7f1ec788303c7f458d06791"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.144-rp/x86_64-apple-darwin/axp"
      sha256 "fe43c6e8b86b60fddbf61dcb461f16eb2a062fbb94d22a8b2941842a3972eb9e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.144-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "815de529a2731521c9f43a5f2f8da5fa6fa22172f847d822799c21f7139e9641"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.144-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "fb50153148e3faf5502934e68ba0f19c414f101f54e589e70adacc2d0f768d24"
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
