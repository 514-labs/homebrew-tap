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
  version "0.5.232-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.232-rp/aarch64-apple-darwin/axp"
      sha256 "43a5e383e2595944de241a108481b2d1d578dc36b05c2d6d94ba5334567f42fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.232-rp/x86_64-apple-darwin/axp"
      sha256 "a414f098b817257aecd8f4236c7580feee3ca20b2125c9335a52d001bec06ced"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.232-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "8f65cf6d393376a0bf1e8a7c6adb25ae5d08991708b64df19692806da30b2ecc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.232-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6715bdf2091e273ca32808718d0be6c9d0c51a09bf42aa84cffef632f1da9551"
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
