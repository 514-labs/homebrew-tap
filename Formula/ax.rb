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
  version "0.5.173-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.173-rp/aarch64-apple-darwin/ax"
      sha256 "4da7dd3de11e7e4f7c4197d452d5120f3c6f08ef0fe603e4fb6409319950faa9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.173-rp/x86_64-apple-darwin/ax"
      sha256 "ac5cdf92ad8b36a4ffdf960ca943593e82407c6369338f6683a28df064e9eecd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.173-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "7161dc2b1110771004c3894430cf8bd13b237ae56be44289b9793bc312d04969"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.173-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "d6fd41e4095e000267f6047823729879ba1e4369c39fcbfe99ee6f876f62c2f9"
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
