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
  version "0.5.112-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.112-rp/aarch64-apple-darwin/axp"
      sha256 "7b8bd5338abd80f4b7dc8180e5d16690a319dd8d5fb8fb5a252b65e3dce52c58"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.112-rp/x86_64-apple-darwin/axp"
      sha256 "8be3d853934feecc39cd34e8c2f91a70eb9344a4fdd6ecbf21c246784290690d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.112-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "4b63f537e1f5ab5b47f6e94d08e5ec84b06986c7202edab59140bedaf08a88da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.112-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "081873d094a177a204cadbe208db553fe4baa28913ee3a017615ee1f564d5c18"
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
