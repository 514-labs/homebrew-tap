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
  version "0.5.227-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.227-rp/aarch64-apple-darwin/axp"
      sha256 "3335fd3b4d74af08efb7e3769d66ee4e22285c4961932033f2c6bd4e8b8e099e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.227-rp/x86_64-apple-darwin/axp"
      sha256 "42b84701029578a37c31f80ed3831c77d9e8b8188e9790b52635d17fac357221"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.227-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "9bc999d463d213d285b1810b8361e8bcfd37d8045c86c9eaf66581e07ce53770"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.227-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "82627e3414332d137e0c24a1576c3fcdbc1cb6ef1925331a2e15c73fa8bc5006"
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
