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
  version "0.5.125-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.125-rp/aarch64-apple-darwin/axp"
      sha256 "b558a3fa6c88a0cc3edbf273cd6c5cd09ba407ddbad7d3d6a75c67bddddf4341"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.125-rp/x86_64-apple-darwin/axp"
      sha256 "68e245ca82717fb371f887df502cdf91fddf0d15c99cf3449aac8bbd27abad9e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.125-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b7fd04f3738e73ee39747d87cf330c97ebe0e1cee6a950282f219f7a386931f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.125-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a7d378685f01366b517a60607d115c8f362b1ee3756b259aad5f08e52a5f4e56"
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
