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
  version "0.5.67-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.67-rp/aarch64-apple-darwin/axp"
      sha256 "ec18a916ee5d33faefec9cd23c37b8dbff98b0df38f1eb2cfe8397e1d3165000"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.67-rp/x86_64-apple-darwin/axp"
      sha256 "479b2832369ea45ffed987b3d37043eb1e38578ce5152e574b09b11f7a8947eb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.67-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a544fd6566b86e1c5695a96bc8e7b7594b7c640749ddc0b3a27da8ae9c9efe83"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.67-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a413b2177d05647c1c1b0bc89d6c9284e7bf1d581820f20734ae3022703e7eea"
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
