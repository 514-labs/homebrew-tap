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
  version "0.5.130-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.130-rp/aarch64-apple-darwin/axp"
      sha256 "7b9d695aa8c63f929c5c2bb47b4ba7a3f1bcf6f49d264f13994ebab1677d6a70"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.130-rp/x86_64-apple-darwin/axp"
      sha256 "ce49829c16f382ac0b8f90e47df0750b66cae98ac5b2159a50fe69150bbecfc8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.130-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a86e1b5b857f595d5112522ab9819c930e5217e4ef92f2629158cbbcb62250ce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.130-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6770559909d243921735bce95e8d090b0249b2aa317b0f0ca3c4f221627823cc"
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
