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
  version "0.5.101-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.101-rp/aarch64-apple-darwin/axp"
      sha256 "e54d08b1914b87758049ba84c7b420cc99e233b0cd674fc7098b5a7eea90f793"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.101-rp/x86_64-apple-darwin/axp"
      sha256 "c87a75742a8c5a734dc1622a4bc438e3e964080d0893228f684a4c597e004fd7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.101-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "2c05651ba76042bd0e24a03e3bd6f76eb0ac146fcc738cbb1630e802376ad48f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.101-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "ef641d9ccd0f2c5bd70b8066577b4da800b4f5b41491d729a5f341433ce4044b"
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
