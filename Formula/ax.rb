# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.225-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.225-rp/aarch64-apple-darwin/ax"
      sha256 "8021b45358defc2565d8dbff447b6408fdd42d23c1ef1d703c6de67fa8d17d99"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.225-rp/x86_64-apple-darwin/ax"
      sha256 "8e367d07dcfdef4e2a696471e9719d15510a370b5a2dcfb3b3f936f6d9f6999d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.225-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "dd3fa95ba82a7932341d729a46987d5bd8cf9b653ff19097f95f9752dc7890c5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.225-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "62fdd54b8ed2e2f42b1aad666b0554ff13b253906badd2d940069163ae648061"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `ax` (the CDN object's basename); put it on PATH.
    bin.install "ax"
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
          ax auth login --token <token>

      Author intro experiment (CLI install test experiment):
          ax intro <name> --cli <cli> --target-description '<description>' --install-docs <url> --install-command '<cmd>' --smoke-command '<cmd>'
          ax auth login --token <token> → ax experiment validate <experiment.yaml>
          ax run [--variant <id>] [--repeat <n>] <experiment.yaml>
          ax query "SHOW TABLES" --table

      Docs:
          https://docs.514.ax/docs/getting-started
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
