# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.179-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.179-rp/aarch64-apple-darwin/axp"
      sha256 "8c5131c9f57e44cbdc56f4ba3ef2404e232456a430c91cb7470fc138faca4ee9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.179-rp/x86_64-apple-darwin/axp"
      sha256 "222d193682110f27d0b76ad05c72d8baab662e74c10275806298aaa728e566bd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.179-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b0c5c9b2a1d6127b105916dd707404dec70294dfb2021581d65ae630b7df2a18"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.179-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6545622659d1837a1f9aa0e17b1f513c4654f022e28c09ff000e41731b8c64b5"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
