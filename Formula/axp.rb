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
  version "0.5.129-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.129-rp/aarch64-apple-darwin/axp"
      sha256 "641f2eab3154bbeec9446bb267896b8ea778605faaeb950b31e0c53d19d9f817"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.129-rp/x86_64-apple-darwin/axp"
      sha256 "a514d210ec85564958bf791c7b43d63b4afcc28cdac6083bf97830c13d6d91bd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.129-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "8873af55d70a18b893726374302c26fee7fa8519fc02d862cc1f4632e4f66065"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.129-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "22e389d051134ef5283ebe07c85adf6f38ec9ef6254863c8c90c1dc865eb8501"
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
