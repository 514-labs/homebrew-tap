# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.185-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.185-rp/aarch64-apple-darwin/ax"
      sha256 "2527cb929ccb83b5865e575bb5d5dac257afeaa9a74bd7102a54fa65e8b20145"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.185-rp/x86_64-apple-darwin/ax"
      sha256 "11d94860c8c452121b88fa2ce5be2ab7596ff491a4741651837ea992a2318fa2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.185-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "099cf8e5ed1568f6ff17f9396f4356060fde759c9f956cff79859dffe9e91650"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.185-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "ca02d6d27fe188d73e9bc7afacccf7839a6b6fd9a9d5124f32cbee3257bde531"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `ax` (the CDN object's basename); put it on PATH.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
