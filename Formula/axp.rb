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
  version "0.5.7-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.7-rp/aarch64-apple-darwin/axp"
      sha256 "e676f495f75c4b963f12881684d3cc3aa668e148c38736de2bafe4ad5e142b3e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.7-rp/x86_64-apple-darwin/axp"
      sha256 "a943710b6f384d1b2204106994f4a2ed9dd082d053be616efbe80f32da0258e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.7-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "c971f36e8304ae8d10ada1525d7670106a8c95307964e63536fa18ec71a3440e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.7-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a7752e69c4cdabeb19ce7cd68c9f0909ef1fc7079ca20785267a30e59af1d49f"
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
