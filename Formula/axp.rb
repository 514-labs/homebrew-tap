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
  version "0.5.113-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.113-rp/aarch64-apple-darwin/axp"
      sha256 "f1c0f16cb52444aa5279dde5ea9429430560ab2f3e1e702cd62d71394b6469b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.113-rp/x86_64-apple-darwin/axp"
      sha256 "1e38cd415f9210c5552027727207ae8b3ebdbef56b7268246a7be4f86a4f6dbe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.113-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "cd9f8e97e160c8c22dec5285b70c6d1318c4d779c5e2f7b1eeb63d1672db6d16"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.113-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "3085cf07acda45b05e8cd6acdbd92d72fb93f5175dd4d396c8d06f035a50eedb"
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
