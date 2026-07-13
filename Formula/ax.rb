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
  version "0.5.187-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.187-rp/aarch64-apple-darwin/ax"
      sha256 "a3fb8cb92ee04f3c9538fcc6ba2fc7c8f713a26b22f4cc49d0db12b7f539b4e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.187-rp/x86_64-apple-darwin/ax"
      sha256 "74cbdb8ebf40535e31813ade8af12ba95f7d99db7700c2db9e2e5dc04d2ea514"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.187-rp/aarch64-unknown-linux-gnu/ax"
      sha256 "151a4ddca59ab31e96e1a47bd6dbad8686a592aa512aba4886b772edbfcdc101"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.187-rp/x86_64-unknown-linux-gnu/ax"
      sha256 "a002da808bd1e3e6781f42391b8e9ce197fce8a13ae3baa8d563078b32196b30"
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
