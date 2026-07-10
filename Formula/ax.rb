# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.146-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.146-rp/aarch64-apple-darwin/ax"
      sha256 "cd9d3d895742dcf7b26e928e55bc49255226ad27ae145c1bf038a8bb4652bc2b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.146-rp/x86_64-apple-darwin/ax"
      sha256 "fd960b10e8c7cc392a79adf711f51c95612d0efcfa59f9217d2804d97b136b9a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.146-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "a3191b71e9981379a3448b5ad67c6317e7ec9b2b05a800d6bd5e1fdccae42ece"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.146-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "85f93767f390240bd8ac81f0d8946138d8023b024621695d788511c5221a91d1"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `ax` (the CDN object's basename); put it on PATH.
    bin.install "ax"
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
          ax auth login --token <token>

      Author intro experiment (CLI install test experiment):
          ax intro <name> --cli <cli> --target-description '<description>' --install-docs <url> --install-command '<cmd>' --smoke-command '<cmd>'
          ax auth login --token <token> → ax experiment validate <experiment.yaml>
          ax run [--variant <id>] [--repeat <n>] <experiment.yaml>
          ax query "SHOW TABLES" --table

      Docs:
          https://docs.514.ax/docs/getting-started
    EOS
  end

  test do
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
