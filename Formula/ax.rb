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
  version "0.5.192-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.192-rp/aarch64-apple-darwin/ax"
      sha256 "35782a381db74d7ebc2386030ac041459a1915f9a0c189704b470c4e8321ea65"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.192-rp/x86_64-apple-darwin/ax"
      sha256 "23d3d320ae1ad88c453f709d914d015b1bff516d715cfddd6b11e16fb40d4179"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.192-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "72c1e8d350ccdb35e2cea4a63d3adcfe31c4343fc7e7724e8263a359b43af28b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.192-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "efc23df9d746d9ddc226760e512ff98ffcdbb78fdb784a94663906d853dba5cf"
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
