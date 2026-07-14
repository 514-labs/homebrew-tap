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
  version "0.5.203-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.203-rp/aarch64-apple-darwin/ax"
      sha256 "27031c50834e1e168db73f25e14735f4024344aa99fb0ed92274a2e0ad260744"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.203-rp/x86_64-apple-darwin/ax"
      sha256 "6d2e63762b7001b9a468636f4c8a6c63519fee642a9ed580762aff8ec24c8a71"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.203-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "dda8cca2ebd8024003351bfdedab5c7aa29b04082b12dc78a7a684e001276470"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.203-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "115c7eb0aa61a33b9ff4087ac39f65bdb279670f107b7bfc2f7b7dcbf7f7358b"
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
