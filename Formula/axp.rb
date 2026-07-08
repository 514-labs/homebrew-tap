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
  version "0.5.123-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.123-rp/aarch64-apple-darwin/axp"
      sha256 "d83ce0db05e9d0a9a526edac43f34e8cc942dea1c1d2f60cf79fc7b051472a08"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.123-rp/x86_64-apple-darwin/axp"
      sha256 "7ea04adcfddf98239fcfda2086d09e61b627eb7428e29a593aa12b7c36644412"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.123-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b9c5983044131fda08cf9b047ea7efc38de0cebc3ce29ee86c0af2c43453a5be"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.123-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "fc440ebfe256a85953dcfb92bba1ea4455490c6594c7038582143da81788ebc1"
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
