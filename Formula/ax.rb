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
  version "0.5.220-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.220-rp/aarch64-apple-darwin/ax"
      sha256 "c1547f35aafd7a204fb0b6a408aba3b645b2603ffdd46cf031a0605e198a639b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.220-rp/x86_64-apple-darwin/ax"
      sha256 "298eb755fb207762ddac5476e2c94299c36fe7d9a03f925ca9be5e9dbd64443d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.220-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "bc406115c826442f212450af99b9dc4630c885b64a7c89eacd1b3f48a32d3014"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.220-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "65208fdd2778ed6676e460d8aaa1da053f48e278cb52f9b982d6531ded12bf47"
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
