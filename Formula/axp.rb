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
  version "0.5.17-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.17-rp/aarch64-apple-darwin/axp"
      sha256 "0d4f19bdc536f6dcd4ad3041bcc0f0c4017bf904b2d3307b522052c264b49166"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.17-rp/x86_64-apple-darwin/axp"
      sha256 "8e20ea94b5db82ec2746e6f50d8803d324a9b55bda874b525b3f6c461208c73d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.17-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "84f58cc5cf070b6e1d71b37532984cfb09af04ee9a3cb18f1591dfe9d36cc6f5"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.17-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "9408cf743839e7a097ce13a178fcf04a1ef1733a1f30058e4e48148b15e84877"
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
