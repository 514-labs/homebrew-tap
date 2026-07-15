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
  version "0.5.217-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.217-rp/aarch64-apple-darwin/ax"
      sha256 "229237c3bbabf5c5a97021f943f31f1fd03dd1484fd00779579cb31b4f134c0b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.217-rp/x86_64-apple-darwin/ax"
      sha256 "ecbf2925020f0a848c984535b1535bbc3b6b4cbb7e9dfebb7e3a64d014a716d0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.217-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "9afd4fb691848f01350fd60bb3420778722595eb4b86646bb7d7870d63eef71f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.217-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "3c3a8bfdf31b0acf93dfc79cb36b10af1eb0322247b4ba2a996b7e00f896f017"
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
