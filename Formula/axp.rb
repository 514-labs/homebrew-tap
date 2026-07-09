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
  version "0.5.143-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.143-rp/aarch64-apple-darwin/axp"
      sha256 "6fdfb6f4911cb91d01dbd15210aa77705cdd6c6c6559e676ac0e557a9958bd11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.143-rp/x86_64-apple-darwin/axp"
      sha256 "b96d7edccd52b322a3c3e514116516573cba31ed0322845b30a177a51a6edab2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.143-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "1eebc9cb56a87bacdf64e82b5b7e1fc6b106a17eb74133ae49ab24349e96b12d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.143-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "9e82d3a594055e041bc1b8bd58ea301539ba935923a3d0d7cd0e43cb413e52fb"
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
