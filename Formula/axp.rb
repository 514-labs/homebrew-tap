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
  version "0.5.133-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.133-rp/aarch64-apple-darwin/axp"
      sha256 "cef169b9ffc713e2c15ed335bb4726216667359c0a55c96d68a1c4daccbeb16b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.133-rp/x86_64-apple-darwin/axp"
      sha256 "0ea2158b0b7d998533d4137198900457e5d5e70588335acf2a711b9d4fece292"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.133-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "40fa2766468c14cfe03fe19c9dfc250e0b04364a4b8395c3c55ab7446c38f896"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.133-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "3c019566e022dbd4d64d87bd814176434cc0755ef271b4744cef3f33c9f804cb"
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
