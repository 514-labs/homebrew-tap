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
  version "0.5.172-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.172-rp/aarch64-apple-darwin/axp"
      sha256 "36d44d7689c5801f411d76f55d78fb96e695f5b9a2eb38ff519906ff3192234b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.172-rp/x86_64-apple-darwin/axp"
      sha256 "acffb511fc35f73b72017b6a082467efa597ebc9997ddc50e23fd7ec19f9ea5e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.172-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "862829e2e95a0dd7a0228916c54119bb7b5f06c0b708ebc3774e45a8534870c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.172-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6519ad3e19cb386816741f31232b73a702fcb284500a35e438d5185d119c0b71"
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
