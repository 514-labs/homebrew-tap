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
  version "0.5.204-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.204-rp/aarch64-apple-darwin/axp"
      sha256 "cdfa2686692f3d75c3df346d1f7b6208d79bae703f8ff5b88e66858f6f397352"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.204-rp/x86_64-apple-darwin/axp"
      sha256 "ce10f7c875e527efbf4dca49853b9c3adf63f39f79d69772bb427015c2701c13"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.204-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b49c56b7d36855b5b02952088aa7daf37b2fce5c80a9349d51039a4ce130ff04"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.204-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "4624036ab8f24642026c1ca2e2c9bf217a22dec8b18831560ceedad922d1b89c"
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
