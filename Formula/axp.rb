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
  version "0.5.119-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.119-rp/aarch64-apple-darwin/axp"
      sha256 "db55b8f14890175801f4180426589bce12a44361e68ae233015314e2becb12a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.119-rp/x86_64-apple-darwin/axp"
      sha256 "b02f441add6f2554f3f3f097234ccd03d10ce0d3fa27f86ce049f75cbb2cfbb6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.119-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "db3d30676acc42851ae92ec7f2e38dea6bdd2c71dfaa2673dc595f3e3683482f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.119-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "ce9399ff036858f971a9de96e2303cb5ab05b14d482e34d28bbc872c6bd4afac"
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
