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
  version "0.5.111-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.111-rp/aarch64-apple-darwin/axp"
      sha256 "b6f7f8eb74ef40875bdac5f7d2a80d361215fb0816ef71859b6faa64bf2d9759"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.111-rp/x86_64-apple-darwin/axp"
      sha256 "4696b1e76f4cb1682647bf667f8913ef1127d25883574552581d856f792cfb7d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.111-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "67335861479c089bd9e6bb334708dc4124c9fbd7f29806f2b18a5d3f84fa4dd2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.111-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "1ecb830b1e4f0851a0ed86299e02d42cb894afe04fc553ed611c0a836b008ee4"
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
