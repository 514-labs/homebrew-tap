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
  version "0.5.26-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.26-rp/aarch64-apple-darwin/axp"
      sha256 "91426c451f30a7b69a455b557d0bb8c6555851d89d2962904d8b68a7ac1b39f1"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.26-rp/x86_64-apple-darwin/axp"
      sha256 "abf04fefb25678393828ea3e7d4f693d3e22be3248923a52d3f5d965d74c9c56"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.26-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "75bfb5c0709543a913507cc2ad4dac28e69da3ba647c77121b3bcda19df6a6ee"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.26-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "8f0e1a812f694c6c27cc3bf49c0eb01e6b5e84574a1d44ad859c6a33eb34a26e"
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
