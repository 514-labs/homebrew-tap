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
  version "0.5.191-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.191-rp/aarch64-apple-darwin/axp"
      sha256 "5694e28eb59e06a8d4b6ce29a0968e64b9e61ff09857c011dd2ba24191c7503a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.191-rp/x86_64-apple-darwin/axp"
      sha256 "0887e5fff5796ec0461f5db3fd52d2ee70b4d633e515c82ee7d46f0aa28ef416"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.191-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a893eea987705c3629c6dc61f07b590c2ed982903a11f8768e8a13110cca069f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.191-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "68f5e68651b20029c429d2a784acc87097ca73286a86c1f5a825c636347e9789"
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
