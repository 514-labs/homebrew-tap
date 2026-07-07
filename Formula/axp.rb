# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.102-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.102-rp/aarch64-apple-darwin/axp"
      sha256 "b160d2647cfca3cc8e4b795b8015004ce2de39877bf71e62463f151554aa4fca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.102-rp/x86_64-apple-darwin/axp"
      sha256 "d818a864bc01fc71e74d66951729ab4cf8b96a33429626ac93bd4afc7c55929a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.102-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "cd91226c162b2bd4531df4b82ba94da9298e7a20e33e88e5aa357a3c4608af60"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.102-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "78873f0e62a7a35dd75c99757df3120d9a87b57f6895b2acf03042b45e3bd000"
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
          axp auth login --token <token>

      Author intro experiment (CLI install test experiment):
          axp intro <name> --cli <cli> --target-description '<description>' --install-docs <url> --install-command '<cmd>' --smoke-command '<cmd>'
          axp auth login --token <token> → axp experiment validate <experiment.yaml>
          axp run [--variant <id>] [--repeat <n>] <experiment.yaml>
          axp query "SHOW TABLES" --table

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
