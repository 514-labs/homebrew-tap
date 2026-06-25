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
  version "0.5.24-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.24-rp/aarch64-apple-darwin/axp"
      sha256 "6c835735f11b267645e67cb9c3903f476ca75c47f83bae6762c772d38be92a9c"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.24-rp/x86_64-apple-darwin/axp"
      sha256 "96657873857cb0241dfaf7a0000ad665307b05543597fe88c323df9e06e9f145"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.24-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "312eae5a9b9c6d251bbb84263df577edf6c411b636d02f549458b498eb307da3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.24-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "148eb81d82afbd2ae265e9e146e869d64bae139f6f3249dd2f68097d9384a53c"
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
