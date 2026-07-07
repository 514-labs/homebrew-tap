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
  version "0.5.104-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.104-rp/aarch64-apple-darwin/axp"
      sha256 "cd4c6d4b176ef19e014ee6a2c1da382d7d3dcd2083ed57df04cdff471c56a5c1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.104-rp/x86_64-apple-darwin/axp"
      sha256 "d9e03f4e5b280865deab689cc2f0b79060348b51fb417c2282bfbb0488b99c1e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.104-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "eca255cb7e4372486288c6dfa2cc2bf5e7d7d845599e7ba4f7cb72eb15b7d609"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.104-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "81470cd0bcd3e33eabc3cb89e444b38a88adfef8e2491af66e1bbfd8446588c4"
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
