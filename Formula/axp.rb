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
  version "0.5.55-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.55-rp/aarch64-apple-darwin/axp"
      sha256 "92383bd39cbce203bb4f9b86bdd69857f6c65c944e8f2d3ee57c942a8ed4e5a8"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.55-rp/x86_64-apple-darwin/axp"
      sha256 "d38593f0103e325f6ab1cdf3528b9b81907d18c7d56939ad0ea663f9f478620c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.55-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "22199ae855ee1725c676c92f0807f4182132c642a860910785af908d09220cc7"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.55-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "c01321d0c934ce814f26003c08849c195de9bf829206e89dd196bcbf50827ea8"
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
