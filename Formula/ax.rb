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
  version "0.5.155-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.155-rp/aarch64-apple-darwin/ax"
      sha256 "f9e784424f99d7355386f1ac126929fc2a245b90573d428d7719e0bc688604d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.155-rp/x86_64-apple-darwin/ax"
      sha256 "6ab493392a1137a2e67e06f426a472b89c46bcf2947a93c51350a11747953c4c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.155-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "f60a098f4aa2b89b5b505694ea89250ffce839c0e23bf11944c45910dd1cae0b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.155-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "0c0ec7d1638cac98269345b824fa6f9d08baf30bb1ecb22bae626f4ab3097808"
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
