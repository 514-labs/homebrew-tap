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
  version "0.5.222-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.222-rp/aarch64-apple-darwin/ax"
      sha256 "c88e5048c231243595ec1e64a12b7d7db2b7730d0cb8b03c52d68a56c332dd8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.222-rp/x86_64-apple-darwin/ax"
      sha256 "0f4f3cdba4547d98b70680be249bdf46785bfe1b592ae2b246d21187502668a0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.222-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "3c6ba90100ef065a82b0af1ce44993e887c17e8fe66e56ad8b6ae45de1274904"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.222-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "06b66f9018c0f21afcab034fa4f0c2a951395e6e8111dd40a7d797e8d3881352"
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
