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
  version "0.5.127-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.127-rp/aarch64-apple-darwin/axp"
      sha256 "ab32fd90a3ca7ed40bbb0eb57d94c49ac857b14dfab5ebb7072965efc6f762ab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.127-rp/x86_64-apple-darwin/axp"
      sha256 "394d8029db579c8eabc50fb3da6ecf36ed1e775d969f56ba1360cdf4a0660ce0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.127-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "d44f1ca21fc6f7b6e61815b7176a7b9cada6e769e3b8557169d4de54a91b3993"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.127-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b40d1727bf4c0bce10ccd9a13b0b8503e19cea1d3b89f68168773251a5912853"
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
