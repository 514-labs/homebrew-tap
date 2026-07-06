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
  version "0.5.87-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.87-rp/aarch64-apple-darwin/axp"
      sha256 "88f88da587f0bc5160ac7c51ced6da7eca26d3e387cb500f9e71fc72a33dc4eb"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.87-rp/x86_64-apple-darwin/axp"
      sha256 "1a7e7d7529ab010fc13bfa62e5b2f857e5f77c7a456d4971bdd86ae24e9aaaad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.87-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "c9e42ae7736807e71cec5a7308d07d1e05ff7ff80b904d9e5cdb19e566af29d8"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.87-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6a6f8e2669c2cfbc153cef4911604c46e8b88a111b458852bca48066cb7fec9a"
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
