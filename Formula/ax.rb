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
  version "0.5.148-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.148-rp/aarch64-apple-darwin/ax"
      sha256 "d6d2f7742b8ce43c7e5e37eeb7a8c0560566ba63c0320ed279dc0f093f880196"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.148-rp/x86_64-apple-darwin/ax"
      sha256 "c7215ef7031006a4a02429db17da1a63d41a6ae98adc2d8738764da26c8c6a81"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.148-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "9c6b06b72203a028913e1039a6a3b4bd26a92558fda8b4e4034365ced387722e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.148-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "51ab48a300ac797265f12604ec9dbba3e7da3918423df4e9c6deb63b2edb03b6"
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
