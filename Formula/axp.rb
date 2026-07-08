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
  version "0.5.117-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.117-rp/aarch64-apple-darwin/axp"
      sha256 "808ebd19c9f3610a161a5137747b2c458f248f93b6cdb7038a081d3f96b832da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.117-rp/x86_64-apple-darwin/axp"
      sha256 "3e6330af692cb785c5507ec8574235a085cbd7e3a821a28832dc6e5ea2a07b80"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.117-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "904fdcfe2992b61b664e594918c50da71eda2ab809325aa6a1432b6c7b0f11c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.117-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "73e7a56e0daf7fcc7d1053e5c5f2436a14a2e2ab733fb0e165b7e73d4a14c9e8"
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
