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
  version "0.5.114-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.114-rp/aarch64-apple-darwin/axp"
      sha256 "ed55196fa17eaa0f0a4ba258f476af83070aba36d897c7c560508936921dfa44"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.114-rp/x86_64-apple-darwin/axp"
      sha256 "5b6ad82006adf10625f1990a3100b30092fe30ba9bfe96dca33476d3b2ab1ebe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.114-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f46c79c344a75c1b225c6d0b9b2a76786bacb0f079cbba4e7c6b8e3f0e032ff4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.114-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "fe5956a9e7f99da7219ee3b83c5b4c1b96e2ec26c4fcff92511ce0f5e956baff"
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
