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
  version "0.5.105-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.105-rp/aarch64-apple-darwin/axp"
      sha256 "c5ceea561e81a51656a7836e2a7a41bb6b848ee2385a784ffe06f0c93db4cf5a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.105-rp/x86_64-apple-darwin/axp"
      sha256 "f3861d09f6cd357888706ebe000f58e02b89627a837fbcd7b85cf8ad24788e2f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.105-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f3601076962b5dc2219f2a098fe3aaa5e64fab1bd2dd09d68b2e9b1e483c55fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.105-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "db48276c401e0b613128dbe9ae899810c2f71a10e4af23bb87cec8e86609728d"
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
