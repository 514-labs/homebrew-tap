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
  version "0.5.54-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.54-rp/aarch64-apple-darwin/axp"
      sha256 "54d1996b62bbe37b91ae4b70a596279b57f786bf3b389f0c4921d81e0bbc193e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.54-rp/x86_64-apple-darwin/axp"
      sha256 "2862705c99460815a685de448d4966f31027baaae3cda503f287a1fc5755be31"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.54-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "604bca666c67cc56be27e7b85042bfd96e1252eed7939179301dd8f0fb846f39"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.54-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d83d6e46d5dacab276a38b9f0fd7b0430a3eca501a17fcd88ec919195d29b5d1"
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
