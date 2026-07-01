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
  version "0.5.42-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.42-rp/aarch64-apple-darwin/axp"
      sha256 "1c0e6cde51327801232c0eb936a06ac71a5422569e75e835f3a760fe8ad50337"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.42-rp/x86_64-apple-darwin/axp"
      sha256 "ab3ff4401a7e135571b5d8776bd32cdf23d16796cc94c85ba1090e6e6436c43e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.42-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "6fe01bf219169521cf6c3871a79f04b570053710c8eb1bbbc5ca81a83b8a7aea"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.42-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "786cdfda67c1cade4b96c967e4bb5d9fb1080b4b141ed6d3bb1fd46488c6ba37"
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
