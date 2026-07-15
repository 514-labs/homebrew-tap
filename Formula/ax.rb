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
  version "0.5.226-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.226-rp/aarch64-apple-darwin/ax"
      sha256 "89ec7846712a1f983c75f5fa675e5db190388860e5fe03bdc4e33296e0ae409a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.226-rp/x86_64-apple-darwin/ax"
      sha256 "fe6a28a8e8770c51d69d652ee64743ac1d3b3e9cc136d3f96ca1775add089d35"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.226-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "1f8441d8ae20447d8652c8708840433751f5cebd398506910cd6f76c58befe1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.226-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "b96ef565b225ef9a5adce69c8b5a049da3a6b6f371070bac3c2942d79f7950bb"
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
