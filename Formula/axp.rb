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
  version "0.5.142-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.142-rp/aarch64-apple-darwin/axp"
      sha256 "b1df80c3a4f12f10d715191f72e3a995d9a2a625414cfa403c5d84ac3feb2fda"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.142-rp/x86_64-apple-darwin/axp"
      sha256 "9624332ae346bb42e2785c1616ff3f3769d35f01aaa545f04743d8d58e4cf6e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.142-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "e158b7903ab0442048a4a1a2194bd94c29e69306fea1542bc7d53349b2a94351"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.142-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6b4647fbfa60cb367750469f49365f3e8c5fca96a48c4dd273337ea47ec31e52"
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
