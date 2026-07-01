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
  version "0.5.44-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.44-rp/aarch64-apple-darwin/axp"
      sha256 "0220793143906d4b2fe329d8b4f0497fdfed5e6ab64fbbba1356ad888c3d36ae"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.44-rp/x86_64-apple-darwin/axp"
      sha256 "275176b5237e7ea92510db86e8731f9324a79c77244e24a96aee6674cc03e08d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.44-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "6da9ef51dd4c6eedd8f0ab9ede6c0b1caf8ee9652b63c15e42a6823f91e844d3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.44-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a7686133e03d9129d67f361b35f93f1d4e9659d855e0724f12f039504d81aa6c"
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
