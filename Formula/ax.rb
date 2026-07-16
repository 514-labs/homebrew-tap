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
  version "0.5.228-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.228-rp/aarch64-apple-darwin/ax"
      sha256 "899c05521cb66c2be086b4fe36ff26499abc6bf11694f0ff9a4156d24c09883c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.228-rp/x86_64-apple-darwin/ax"
      sha256 "0ed0239af9c477af64eae616f649497c3fec2f557f0a66f73fcc23e4ca6ebe64"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.228-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "c7436db20bf9b95f37b785a982750e5d0c869f4f1b0d9b4e299fca602c13257c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.228-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "bbcaa8b38c52325ed5bad6cabcb58770024ffc8f816b21571e0f44fcb36e9246"
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
