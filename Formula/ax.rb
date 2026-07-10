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
  version "0.5.149-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.149-rp/aarch64-apple-darwin/ax"
      sha256 "b38b35b321a3a0d1bc8ec22ffb8c0e541fac8b7503c675b448796e6e0446d580"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.149-rp/x86_64-apple-darwin/ax"
      sha256 "cf91e112a902b19f34195cb5ebd0a53355e1367d03c762ad045ba1411ada093e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.149-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "4598dd024ac19861212431d65081051e8763c86b39e0066101056dfbb7aaab04"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.149-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "e286482d87bb3d3ca3cf0b7d0b7d307963858cc57e031bd8d56d6065ee3b8116"
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
