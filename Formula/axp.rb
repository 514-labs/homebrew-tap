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
  version "0.5.115-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.115-rp/aarch64-apple-darwin/axp"
      sha256 "59c0d2469247ee6a0c27fbdf5ffca8fc7f5142586096a13db8a37e7dc893316b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.115-rp/x86_64-apple-darwin/axp"
      sha256 "ff9bba218877abf6a15cdc058c5e1d66e3725f2ec3e7fd697cc88379c4508003"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.115-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "bc02c96f467ca38651655404d11f927fac228be2c975c00934e157cfdcd37078"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.115-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "2e804391ecc9575908f4605640346219eb62edd0cd9273cacd2ce945070ca41c"
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
