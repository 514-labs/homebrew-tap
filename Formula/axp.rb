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
  version "0.5.86-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.86-rp/aarch64-apple-darwin/axp"
      sha256 "be004fb2bced1f19b89cd21833b065d4eff9764d53300f93deee547f866bf5e9"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.86-rp/x86_64-apple-darwin/axp"
      sha256 "56b0a0136cf1122886a599b10cc915b6124fe10cc4c95e7cba3c7e8d4a961002"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.86-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "45973b337e38c998fc512fca89a9c87f9c606205ec532443e5e053bae2c664d6"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.86-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b52bd45239f1956dbb8df4456b99c3df45dd48111237c7039f70f8fbb5f32ec2"
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
