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
  version "0.5.201-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.201-rp/aarch64-apple-darwin/ax"
      sha256 "f1a26f600108c917f38d1d2bbe5cfa09ce869c1590fb434252ccbc1991e34173"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.201-rp/x86_64-apple-darwin/ax"
      sha256 "cbe3a59f2f5a829e9bd786ed3784ec135af6b5f689b5834d9e892b649aa26952"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.201-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "055471c67f1f0b31f476a99e426c8ecb8ffaadf35ad0c1cbbb19ca2764d8affa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.201-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "538aa13d20db8ebd3b6f3cc3626e22482f3ba207b8952eef0f906be1de145df4"
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
