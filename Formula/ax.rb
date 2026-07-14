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
  version "0.5.197-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.197-rp/aarch64-apple-darwin/ax"
      sha256 "35d0bb2da7ea00815bdaebfe715ea84ee7711a497ba47493467f636cfbf5ad74"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.197-rp/x86_64-apple-darwin/ax"
      sha256 "ba3f2380afdfb82e8edfb39e93ab0b7cc0bc9511f7a1deaaa5b1f88d06014ca4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.197-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "e69aca477c624e602dd78dcc86f301a4de18f6c7affb75c486f4d70975f27262"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.197-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "49dd5e3f9b8fa2dfd77a385aba95a9bb089cb10585a3cfa5ac681e9a5bafa7ea"
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
