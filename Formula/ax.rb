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
  version "0.5.161-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.161-rp/aarch64-apple-darwin/ax"
      sha256 "765a99fe7f2e25a1f5da4e61f070a806af1f45412a1cbc7f769ba2a66e927b5e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.161-rp/x86_64-apple-darwin/ax"
      sha256 "a185a3c532dd2d4ab68fbb9a5e4e3c751efbc2f98ceacbba9d4b887c64c3a09c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.161-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "48e787a61983eeb0af6e312a86f5f1c1bb330380f61349dc7c1d5ac53e42f270"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.161-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "8538b528fbd384644dbc18e9c6624e3568601f8a2aa139bba69bd3bfc1f58db1"
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
