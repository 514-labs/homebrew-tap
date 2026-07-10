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
  version "0.5.145-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.145-rp/aarch64-apple-darwin/axp"
      sha256 "6873cc54b31964d99fdf771701b367cef14a51e95ceca1048c40c291a7e43df1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.145-rp/x86_64-apple-darwin/axp"
      sha256 "757f062e3904683b80d4b19faa8830424f62c1b862cdb97face6aab60bc116a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.145-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "05b323f1620f1e4d1002071e28f3c61758916be043ee5dba856a479e10a0d6a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.145-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "421b5823d5be449bbcbb803c80f9aeef6a9cb2ec7caef341980602664401ee2c"
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
