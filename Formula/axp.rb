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
  version "0.5.121-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.121-rp/aarch64-apple-darwin/axp"
      sha256 "7ccfb0b4c0c588da1b3531fa1aafe01e56f168f40122f75c6dff33daa45cc466"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.121-rp/x86_64-apple-darwin/axp"
      sha256 "b0c74b6c884e83cd33cd617e061718abd303701bb7bfd8bb0bbdc040dfbde8f6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.121-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "5c55bfdb847b66de003a080b40ec9de3204e4d9dc1e2b0cc3092faa5267b5287"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.121-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "0efa5714c2846d85a345d398a40a93723c862ac80c225a74e2a2e9161c6c8025"
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
