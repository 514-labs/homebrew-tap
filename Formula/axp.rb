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
  homepage "https://514.ai"
  version "0.5.92-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.92-rp/aarch64-apple-darwin/axp"
      sha256 "6e706294a06a578fa5972f2bb996ae7592803db3b3fb8d8b7e00eb72936da07a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.92-rp/x86_64-apple-darwin/axp"
      sha256 "69d8fed49c1dab4aae04b0a9ed465b18ffb1b8c25e0e258fec343d238aefaf5f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.92-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f912c65d1cff15be63e122658e068a6581744213b1334c59a0cc86718fd17c7f"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.92-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e24e47a8ef713dc1636ba1d7c4f6715b56ebc3b88632862e5e2b16edd006cc16"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch binary, staged as
    # `axp` (the CDN object's basename); put it on PATH.
    bin.install "axp"
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
