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
  version "0.5.147-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.147-rp/aarch64-apple-darwin/ax"
      sha256 "93f3de4edaff2ac4972b03d54f41e8e164c67bf3a819cdc49bdb2911244a2b85"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.147-rp/x86_64-apple-darwin/ax"
      sha256 "b4ac7451a4360251174bfa498c25df4ef7a11ef96ab5ee6a17b9acc703b55c46"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.147-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "0c6f325e765ff5f34bf44d1c852f3eb47dc8b693e7b99a39b5b2aa268b0b51f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.147-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "97fc4203adc221094f9e32373e1caf778d4c39be72c0e3367e69f028f2c51a80"
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
