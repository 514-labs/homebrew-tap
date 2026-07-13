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
  version "0.5.181-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.181-rp/aarch64-apple-darwin/ax"
      sha256 "15919fa47700858a48bcee8a69c7a7977d7d611f44fa66a8096f57806970ac93"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.181-rp/x86_64-apple-darwin/ax"
      sha256 "10d57aa01dd7613e336fb98051629c11e098d1c2d965aac2214bc9669325ba51"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.181-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "1b9f1428050f0bcf14ae45b343e83deba0bd15782473b97a9388326b7c9cb728"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.181-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "507bbe879b64f038fd4ec4b212e29650e4631d30b8e80f2fbb3ca09dc4dc2eca"
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
