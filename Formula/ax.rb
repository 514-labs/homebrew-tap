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
  version "0.5.168-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.168-rp/aarch64-apple-darwin/ax"
      sha256 "78648ca3255c3ae87152d65425b405b6c89c041cb4b74465864b4e3223841267"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.168-rp/x86_64-apple-darwin/ax"
      sha256 "63f4c6501b342df1bf44e61935ecaff0a1c853ce4a3362b6d04d9eced5ff08ad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.168-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "eb5baa3c79c9563f3646bc62f16ef7ee0f926108f77acda460ffe61e0119fa3f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.168-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "bdc155c4d77da2399fcce16dad1d0c23f309cfdd5c6b5f70dffc9cc96758ec3c"
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
