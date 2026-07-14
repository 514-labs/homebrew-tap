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
  version "0.5.188-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.188-rp/aarch64-apple-darwin/ax"
      sha256 "7acb777e275448a65ad3adf416aab99b101c12626c3f3c47f249378f8b66021e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.188-rp/x86_64-apple-darwin/ax"
      sha256 "b5d5e25dbb2da175a86b19439f6c6ca4a7c9304c98c2d76d10658450438b6a5e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.188-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "a34b65d803a9640e8c2eb6afdceb5cd2ab7582ad28ef4984497407b634dbfea2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.188-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "4f8c1bcb33152722f021a0dfb15ded06bbfbe2fe90dbfee6968952337c1bb902"
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
