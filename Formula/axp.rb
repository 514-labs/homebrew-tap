# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.194-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.194-rp/aarch64-apple-darwin/axp"
      sha256 "8dcb35ef0247941ad642c862ebfa08a1f8ce757758355b9e1b6efe8c3d7c8f4f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.194-rp/x86_64-apple-darwin/axp"
      sha256 "2d382c48621e8b11e35a6f7da66db44e0e8349c8f7102a72aaf14683529db239"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.194-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "5b258466870e27153f115fb50e4ae1a49b8a18baa31cecf705f3d747bd69531c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.194-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b350ee64405baf5767f9589a493c8eeeb7b46d9ffc0a2cc4dd614203c519844d"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `axp` (the CDN object's basename); put it on PATH.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
