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
  version "0.5.80-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.80-rp/aarch64-apple-darwin/axp"
      sha256 "f4e2e13eb767c2dfbf7498e2957c644b396f55666686f0faa5985ab6351b5025"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.80-rp/x86_64-apple-darwin/axp"
      sha256 "76053c8fd3ae4b3018831d1ffd76d031e86bc6a4a4414379ac5b65ac677b5f76"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.80-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "89d4ad7d4c422b488c940746480d37c8d93fc66883cb905bbb2422d98aa251b4"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.80-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "8331e1fa8d512cd6be5546f3245a5401f7470895dcd68e45224bb3badeae0b8b"
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
