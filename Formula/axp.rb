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
  version "0.5.109-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.109-rp/aarch64-apple-darwin/axp"
      sha256 "1a8b0da609203bf00cf26395edd083688e82d40c444cb6077644d63f5cd7bab3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.109-rp/x86_64-apple-darwin/axp"
      sha256 "d3f25591fbb3abba5cfb59163dc8c1bb5cb07a07337b2f22b4af0f1f5c40830f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.109-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "1df6d0fcf2bb6fc047f33c22ef78d28e0527c33654f146c47574a668e0f47cfb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.109-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "824c5e841828e8cc8eb47e2aeb5022c551cb27f023c262ec67056579da4e670c"
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
