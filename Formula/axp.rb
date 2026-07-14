# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.212-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.212-rp/aarch64-apple-darwin/axp"
      sha256 "ba68224f85d44036c3644493aa69f092c1c8c97978794ceb134532dff78f1a10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.212-rp/x86_64-apple-darwin/axp"
      sha256 "dfadf374cca76d2cd72bd8876517f5e51c6ad492948da7d1aefb61690f7a6f03"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.212-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "c5c1670c61ef772a269965595a94049f3038cb5a3f007662f4b11c43e34fc0cf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.212-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "91c3a9ee42c29efd5b2c3f18195a29740cb3a228fd2b8e3622f78efa24bae813"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
