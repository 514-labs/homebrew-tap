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
  version "0.5.209-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.209-rp/aarch64-apple-darwin/axp"
      sha256 "03e5ab4f002f81fddd7eb62f9c814c8d3aecb053e2ad23b8255103dad4b19bcf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.209-rp/x86_64-apple-darwin/axp"
      sha256 "0ca910be567598fb58218047f8b72b14298862680fc66eb6dc762a1b1e3f3e1c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.209-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "bcb55926d39ce8ae6e7e6d558ebb422995a4ff3717dbb19217200821bf1495c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.209-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b74e8f13087655cf3cad871eb1c2c26d753afaa421e514afd28bda99ae07a736"
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
