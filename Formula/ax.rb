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
  version "0.5.218-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.218-rp/aarch64-apple-darwin/ax"
      sha256 "43acc225c7be401ad7212f399d3d4fa054425a36d7ac8b5f4c0ffaf3c6f38f2f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.218-rp/x86_64-apple-darwin/ax"
      sha256 "ac8ac1ef336a62f37048f806f56baf0269cae97db6e64d2a553789336a61b7c5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.218-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "7b9016c23bb10ecce5b89b5c52e4aeb7c5cda47b4f9b1ba44fb787cb2e4c984b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.218-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "4f9128b0eb5cfda14cb41126f412f4cfbd94669e4fada9960d2fd1d7a72001dd"
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
