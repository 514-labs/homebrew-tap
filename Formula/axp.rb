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
  version "0.5.14-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.14-rp/aarch64-apple-darwin/axp"
      sha256 "4ba36487b4d08ecf715aa5b754b23076986095345a1384e148a68ca7095f1990"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.14-rp/x86_64-apple-darwin/axp"
      sha256 "28eb2bd8a586e848953800254acf1614cdd3a437b7a2fd6fabcd2690e364fb8b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.14-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "16af8346bd800af90e151281e7c87fad5c5120ba59afa4b9427d18ad1b5659c5"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.14-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d8b72f346701c6578e9eedf9dd737e886ba9144290c6e7ba31b354a7ed7ef305"
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
