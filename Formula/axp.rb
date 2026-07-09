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
  version "0.5.138-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.138-rp/aarch64-apple-darwin/axp"
      sha256 "5bf0d9bc7bfc5b2470e0bb38d6fb623394dd29acacb5bb780147aed0fed4f9e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.138-rp/x86_64-apple-darwin/axp"
      sha256 "a22e5d7e61fa783b02bff3a5158074d4a49cb2783c926c6c2fc79fb75a8e3ce6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.138-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "277dda3de9e368e6c08b51d76796fbde2c38079bef43ca13877a4b1711543777"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.138-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e3ed922794c9afe51a48cf8c4a73112138596b9990e5dae13d161341a1862b95"
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
