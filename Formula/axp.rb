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
  version "0.5.134-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.134-rp/aarch64-apple-darwin/axp"
      sha256 "37e515b94c351d58598e4393c46ffca57a4b83821ea61d10972980482f9fc54f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.134-rp/x86_64-apple-darwin/axp"
      sha256 "42ddfe8e09654109d97e3a8661910973a2da9c5ba54134e44847aa6b9095ad52"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.134-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "cd00368bcc9f82b72a468e75197ee7a89fa14aca3705bda022654a6dc6d1faf0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.134-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "940effe244b80efbae7754ca272c3faf84f363e89e1559f917acfd5bc52bb27d"
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
