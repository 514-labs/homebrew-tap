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
  version "0.5.116-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.116-rp/aarch64-apple-darwin/axp"
      sha256 "d7ec9abcb4e9a1fb978d5c5eda3d4e226056054569f8e273a6438a6f988deadb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.116-rp/x86_64-apple-darwin/axp"
      sha256 "ac589d7ae378d2cb72ea128799a172ebba5ce83f6c45b693d1ee29738caf12ea"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.116-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "caa5d8e537e6cb10a0f69955d83f2ee7ce77ea5631491c7dc2fb2bf109a52853"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.116-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "68855a9b0a06e58aa940a2552c43015b909c1d8b45c3df183add9c70dc11e8c5"
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
