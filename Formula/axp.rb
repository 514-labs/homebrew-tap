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
  version "0.5.45-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.45-rp/aarch64-apple-darwin/axp"
      sha256 "0a50787cc0901e25ae075758fc9ce4b161aef5884a1f4580fd707087745678d3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.45-rp/x86_64-apple-darwin/axp"
      sha256 "a410d77345d85b6a5b7230f421c547a771995577befe787a30a0980a56f350d1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.45-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "e9b8fab0b085cc821f890aa0a1ff8db2655d63d4acb16b7a5d18d7ba8bb136f3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.45-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e841a6a59e7ebad84d3f33eb32f731bce5f9a829fd3126e3f41d86826ea945cc"
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
