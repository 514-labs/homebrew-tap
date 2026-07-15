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
  version "0.5.224-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.224-rp/aarch64-apple-darwin/ax"
      sha256 "ca02efe0d3abf92b680294198b19bac63c048d61d374d81de389c7827867cef5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.224-rp/x86_64-apple-darwin/ax"
      sha256 "7fbd080309cdae087e21d2a3bbdc279131c9b27133ff1fb9f10c29e1d4d2e57e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.224-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "e6f947083ccd887f7373b6eaf78888b88829d47c28a9cd622def6a11cca80a14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.224-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "f13bf1633c7cee83826533781fe8ad86671b1803c55e6a191c73ab3671dcf145"
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
