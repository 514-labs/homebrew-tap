# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.153-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.153-rp/aarch64-apple-darwin/axp"
      sha256 "63887926c7fe070eb171acb318a799ff886aea9961a8fc3450c124944cc7b970"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.153-rp/x86_64-apple-darwin/axp"
      sha256 "e39ce45d7d9b2ece7c19d60a2b03c2e0ee016bce6a3c23191dcdfe8b7fc881d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.153-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "0ed73e9705f5f7c939795ca38d1f46e2d28b5cdec60f707f3f5519b2c1f9a985"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.153-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "2246e05933b045ca4f3cbbcf21153a3abf373be664082371e912d5422c46cce2"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
