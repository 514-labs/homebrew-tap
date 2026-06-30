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
  version "0.5.33-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.33-rp/aarch64-apple-darwin/axp"
      sha256 "dd70b365328972c619ade18a575734e378d8e63c36a20219bc45d90df9db9ca6"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.33-rp/x86_64-apple-darwin/axp"
      sha256 "f0fe58a0901152a98aaef22ec04081e687ed0f4b2b979ebf6304fecae6ed97f2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.33-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "966091fba8c17091bc623bc69a33414fc69a0cd4477553ca8c3ab5ef9a2b7883"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.33-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "86d1178b75a88741aa884be8e2a877f88bc5b0b3b7cd52fdccbf899ff8c26faa"
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
