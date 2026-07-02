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
  version "0.5.53-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.53-rp/aarch64-apple-darwin/axp"
      sha256 "5843aaced72583c244e0a72c4a5d974c329f4b5684f21821d51da310eb708632"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.53-rp/x86_64-apple-darwin/axp"
      sha256 "cd01643ba86e9ba28e5215dde5620026329737db1928cd9f9b538ce8aed86759"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.53-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "c857f4aab4b1e74ce47e98f85275db733ea8ee61e898d30da034740dc009983a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.53-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "771fa55abc7cfa34f6318e7ae2043bdd9d9af2866192eb16f12c99be4905dcac"
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
