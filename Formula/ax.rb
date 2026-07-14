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
  version "0.5.206-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.206-rp/aarch64-apple-darwin/ax"
      sha256 "9ca1aea9227e15fc30f8fd2803b64f74fe26d586d0e8a78424dcc5c086f82ee4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.206-rp/x86_64-apple-darwin/ax"
      sha256 "9dee42a07b377b89d68da29daa37bced06400b382104339fb6d2d3ed2d9c08eb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.206-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "f951f987ab99312b66527b3a6e8bf775b5a624676fee43bd7e16b1442ce3aebe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.206-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "78c9d3ad237b9b05a6db773cae2297c0e99062b36762c707b5221b50b1169fae"
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
