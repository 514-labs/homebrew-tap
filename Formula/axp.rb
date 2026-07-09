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
  version "0.5.136-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.136-rp/aarch64-apple-darwin/axp"
      sha256 "6c8b3333e1f75e06768fa9aa53cebb569cfb95594a569fb4d1afd1211b89e165"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.136-rp/x86_64-apple-darwin/axp"
      sha256 "36193a31fb7d42c30e3260a53f8d4ae45caab9f8be76fae46ad14ef0847d273f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.136-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "9d78efeb2adf4db616f2573fd946b00ca7287dad8066e5ceb79d4acb4d62a574"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.136-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b7a2cf2b8b6b72384b934c54e71cd08de4f93d7479ed67eca0144c8d50d76202"
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
