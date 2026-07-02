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
  version "0.5.49-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.49-rp/aarch64-apple-darwin/axp"
      sha256 "1b0e6620c38afef71348f6d04a523e1090ec50dbb2ab873dda30d1aaa709ef73"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.49-rp/x86_64-apple-darwin/axp"
      sha256 "54df2e6d3ea14941c7bc120faebb3673f1e4f2fbd3bfef96a53c4b5f9ee64bed"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.49-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "ea7d47c3f2811d99075d0a50009cb3a69a3f927c1447b63fe5bc10ea7164510c"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.49-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "3de4b1ea093b760994b1c7ec247577f6eab40a9ab2d146b7fb903c6897d9559a"
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
