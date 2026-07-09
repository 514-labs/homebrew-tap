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
  version "0.5.141-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.141-rp/aarch64-apple-darwin/axp"
      sha256 "0109c33a4707dbfd478936e66da7b22fe1462d630a587d0cfbbd2d7d15d3f1e0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.141-rp/x86_64-apple-darwin/axp"
      sha256 "3701e327f3c13b693b279f98bb5f8831511eb600a3fad78365c3e5cfd9e3e3a5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.141-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "d3801bb9fca01f5b4a41bcaf7bede51e664a539fcef6cd4ffff7f1f97adf6d4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.141-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "21b25f76790c975ebb307568bb75ec28c20027b0be8de15ac54bd7c54c091f5c"
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
