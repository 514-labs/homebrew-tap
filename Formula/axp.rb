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
  version "0.5.107-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.107-rp/aarch64-apple-darwin/axp"
      sha256 "88e81c1ff6e3f483bbb5cfd17e2630b6e89b344e46674bce754b7876f7477827"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.107-rp/x86_64-apple-darwin/axp"
      sha256 "8063867ddb581c3a2ff973cde2e2af6dad45e5ea2e2c25168d8e0e46475d751e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.107-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "d3a5440e47754307b61fa9ecf316a962d01f45bf7c098e74f271cb3e634523b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.107-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "1e1a044873a6c171f5f35e08b028908f2d4372bec7fedeb4ecd2bf6038c1d332"
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
