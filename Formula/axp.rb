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
  version "0.5.66-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.66-rp/aarch64-apple-darwin/axp"
      sha256 "c9aca53e0860d703f4f1b460bef5989f4de03826246e16aae1b9aa600340702f"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.66-rp/x86_64-apple-darwin/axp"
      sha256 "15044731ba95ec9b53dafd6c421bc6f8fa2e575efe0f16f2c3cc85c849344d00"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.66-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b3b94b129041ca122ee104714f9f56257d6c8f6adb299e6cfb6e98a6aaa94137"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.66-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "811d561afa6979b921cdb05e96cdf6909938f206f724bed961bcfdd46ea0f7e7"
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
