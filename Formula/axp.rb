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
  version "0.5.131-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.131-rp/aarch64-apple-darwin/axp"
      sha256 "a27893cd53992e71b3288b400281281ed013924c9a7db2d76d0e5a9bc4b64d8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.131-rp/x86_64-apple-darwin/axp"
      sha256 "8b60c2411268dde95b4529f183223f78111de941e019e7b53d09ebea28c4f085"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.131-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "3ba5f7c7956d7ce3a197c285d595e3da12c78fcfb7c960a6754b7976e01f3678"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.131-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "7ba3bba6e02a928743a28d38418a255ce3e22b989dac07276110568d9aa715dc"
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
