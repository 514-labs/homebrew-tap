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
  version "0.5.77-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.77-rp/aarch64-apple-darwin/axp"
      sha256 "49cea89ff5a86f320eeb659bcfd68d9d83cdddada2bcfc78d6110773f15b77ad"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.77-rp/x86_64-apple-darwin/axp"
      sha256 "f714e71d0a5e9fd8056ebf9f3d41332a1931c7b32c3ac18746c2d764ef0bf9f9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.77-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b6fb06f157388dd52f870d9f63a00c794abf6a119f98fd3bce0d50359660da82"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.77-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e08b5ff4da35841a816616def8eee1cf94e966ba820f35aec5670149e9822e5a"
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
