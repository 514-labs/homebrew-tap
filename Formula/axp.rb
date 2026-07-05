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
  version "0.5.68-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.68-rp/aarch64-apple-darwin/axp"
      sha256 "c07ec92dd5d6c11f9be7cdddeaf31d3cdb10591a4546ec90d03c6c3ec5ec87f4"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.68-rp/x86_64-apple-darwin/axp"
      sha256 "8bc8bbe714b363d6c84c90705c0505a7b38e79304619bf0b4e9cc699977e0210"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.68-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b445c354b15d3458fd283934d46a6def81afd8e3f5adbd03d0aab298d09131aa"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.68-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a8fb19ff564b628f09d4b1b472a22f0100df0c399f6a2ed008b5932caa2a0669"
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
