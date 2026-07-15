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
  version "0.5.219-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.219-rp/aarch64-apple-darwin/ax"
      sha256 "a37d52a9567175244967addd190fe46792b4d514b287d8d3ef68251f534e26b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.219-rp/x86_64-apple-darwin/ax"
      sha256 "4a6d125e63b609bb5922db8376a061a21d00bdd8f4a8d736a8b12714981729f1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.219-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "9282a134d58a056c31446859a4f66d97e2313dec5c50bd6460950086292e2ece"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.219-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "285bd2017561fc3ba63cbe9a961b0341ac185e2f0d5de87422f356577b880458"
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
