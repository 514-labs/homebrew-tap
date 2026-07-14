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
  version "0.5.195-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.195-rp/aarch64-apple-darwin/ax"
      sha256 "4a4310dc0b6e9f50f1d526ec8e8ee4a07f0e1324230a454bd8bbb845cf5449df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.195-rp/x86_64-apple-darwin/ax"
      sha256 "68406e2a54a3d135c52d873a20b27100134ed3129a1b0ab003cfd7a7b48827d7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.195-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "5eee5665c001febdd4445bd44e12c8253074dc074565733b2109865c6572d345"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.195-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "5b1142a431eb20260f0b1425a9f1dc3489f9f1abe6ced9806db0a4d9c2b10769"
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
