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
  version "0.5.108-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.108-rp/aarch64-apple-darwin/axp"
      sha256 "1caf1977da397fa4ee15c4991a98a0a5fa3b304893f53c881e0035c507962d2f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.108-rp/x86_64-apple-darwin/axp"
      sha256 "719f98f59794d42b461a1a29989279e06646d7dfb3dc2f0f043da9c27dde9097"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.108-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "22d25ec8fa91ee735da1a221b6b4e85a91dd390c04d461a0552ac4e6738155db"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.108-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "5381da87ea518d9d5927903c7022ea8ae9f5efd046b71d48993dc3a29b2c613e"
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
