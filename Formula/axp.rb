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
  version "0.5.137-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.137-rp/aarch64-apple-darwin/axp"
      sha256 "63c781d89849b36188105971bddc2ff21e993a5303ef77b9f27e28ac5f1e0685"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.137-rp/x86_64-apple-darwin/axp"
      sha256 "84f6936696f81764b5eed61570d80a7da3a746ad52d2181f9e7758b0a7c386f6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.137-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "632198012208042c0bccf849399df693949c4868e5a53dbef40df83dfe79b45f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.137-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d4b1fd7423cc0cbfefb8d899fcb0527491806c741ef1d5bd84a75da7d8747d87"
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
