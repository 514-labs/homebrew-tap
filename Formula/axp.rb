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
  version "0.5.8-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.8-rp/aarch64-apple-darwin/axp"
      sha256 "ed9c62b2ab770f3d3e64dcb5d53ce6f54e9f74cbc623cdb761bba4293799bb8a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.8-rp/x86_64-apple-darwin/axp"
      sha256 "2604b9458802175d326044b8ff45539fb0d98246d2ba2c00f3b909d89e144706"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.8-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "ae0c04f6d5e6019ca13bb28a596a19edbcc13b61edde7cf918d4d8bb8954d3c9"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.8-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "c9667507344b06f94f19afa8b2f06599736d4e9069deaf553fc9bcdd73d79578"
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
