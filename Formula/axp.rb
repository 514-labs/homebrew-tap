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
  version "0.5.132-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.132-rp/aarch64-apple-darwin/axp"
      sha256 "59d0cb8e8242a398dc1dbb2db9bdcb8dc775f75bc13c286d23e3fc684a6d451e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.132-rp/x86_64-apple-darwin/axp"
      sha256 "71d43c9806f499aaf9d975f9d208e0b2a34ba3d701e683fa1766cba8252ea0b8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.132-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f9276715203d45580299301172995358a108717988bc1a245e17a0f345e16d17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.132-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "5170c68070216b3a62731cd07f08dbdd156d3e9513e05b04b4ffed82c5379fd2"
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
