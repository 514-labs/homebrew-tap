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
  version "0.5.139-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.139-rp/aarch64-apple-darwin/axp"
      sha256 "eed210f3de7333946a5b77eb09a70d9a49e2d95d4359b61162a7898912cd37c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.139-rp/x86_64-apple-darwin/axp"
      sha256 "fadea70e6f37b0656420fd329685cd9c106111b688786a1c8463f81c5da9bdca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.139-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "9e270dbb96aa07021fd0ac6f0051cad9c5d5cf088af95807c95e573a775a69f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.139-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a1ed4b898bb048f061250f9f3b85aa9df8d284f40e650dae69d3bdb5d78dd693"
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
