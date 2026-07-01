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
  version "0.5.41-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.41-rp/aarch64-apple-darwin/axp"
      sha256 "203911dde84a6fd115db89ee0f51c8c31be126198af4906e305099752b9ba843"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.41-rp/x86_64-apple-darwin/axp"
      sha256 "1e99fd9d0f0160e8727094f6688006e1e82b08c467db5cdd6e583aeba5546739"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.41-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "129baba90b1ef09fa4b9da5adb7dbe4330169d4c722c5915dc03646e8b9e6db7"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.41-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "513d0a7a8b1915ecf355a7f0bc3153f8d591559f6befb2aa7725577d95a502bb"
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
