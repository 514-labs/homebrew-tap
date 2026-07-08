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
  version "0.5.118-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.118-rp/aarch64-apple-darwin/axp"
      sha256 "838c5ccbd7525a826643b00ef21f095196d7cceac5fc6c8a84087b9cc56f473c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.118-rp/x86_64-apple-darwin/axp"
      sha256 "9730d220aa3aa12fab63af3dee7ae1cce51fc67eeabc52e2043cba197fe5348a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.118-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a2c453ee7c478343ec8d1c4431dd7ac8db6e5d39f35921699c8080f453e79742"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.118-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a888c3d1b885b1a5864ae412ba080b28d2c76aed4a399f806d4887621d12a57d"
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
