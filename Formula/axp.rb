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
  version "0.5.81-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.81-rp/aarch64-apple-darwin/axp"
      sha256 "bda502fc5dc0ebc3378353561347885a4b176c3adc0dcb6cd328f1155160d870"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.81-rp/x86_64-apple-darwin/axp"
      sha256 "ce5b2d2198bd9f75b30a5fc72e633ed9eaa924152b3a62e594817fe1d184f9e4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.81-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "657c63488f2e36241d50249cb513a7f3bdecca7f2d5a7ef544e8ff5abb74a783"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.81-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d64a4a0796f5e5700bc3767b1bdab6db060c60dcf083888ca06025e20b97d6e8"
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
