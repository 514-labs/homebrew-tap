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
  version "0.5.106-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.106-rp/aarch64-apple-darwin/axp"
      sha256 "503abe85f98bdc6e9574a0c5c62900c4019a13f3c32a366ccdc78451cafd9e20"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.106-rp/x86_64-apple-darwin/axp"
      sha256 "09ad6df3808fc95f08eaa5d51d0117ef00d7a103650ad94dbfe2638276ddaca1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.106-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "48cf24253cc602f8022044d9759c392bedd235d41484f8d8e106d11a58334c8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.106-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "fdeef88b8c16d96d77b9d6ecdfbaafbfe0d7a996811cde6354fd24ab4ee8c98b"
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
