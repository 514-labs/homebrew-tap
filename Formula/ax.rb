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
  version "0.5.202-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.202-rp/aarch64-apple-darwin/ax"
      sha256 "4ec618538ea1a696b47c0032785c10b4dccc51cd0f8e33b1bfcec036b0701dce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.202-rp/x86_64-apple-darwin/ax"
      sha256 "c6bbfa6b554b3d5c69cd616374d8c3a4f53d911f13804a23fa7c359ce9856d91"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.202-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "5771231eb02b54a5e4a670ff3006d4807ef119d86e7d6d0d9081a03550446554"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.202-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "8a516916e3f2818d38306c1b28b344d278aa19f396748a0da7427c295587f369"
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
