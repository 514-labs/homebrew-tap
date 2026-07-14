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
  version "0.5.196-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.196-rp/aarch64-apple-darwin/axp"
      sha256 "7198f2f2d5e5e0caf184f6824837f5be576cf5fb83efc2d0edc802553f6a57c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.196-rp/x86_64-apple-darwin/axp"
      sha256 "a195fd3012f653da63a8d60510430860ea4f96f60480f83c2285eea6d4c398c4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.196-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "36f20b0ca041f2079b478f96f0b7cab30330a6194b74ca7aff06725446d087f4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.196-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "79fb098d0c6c851fa5411324a97b7a275faca4577abd32e884cf9d0a7ea72892"
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
