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
  homepage "https://514.ax"
  version "0.5.95-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.95-rp/aarch64-apple-darwin/axp"
      sha256 "c554fa4d959c0414d30609b1ccf977768f4bf3b5ec190e10e9b2a3dbb25e241e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.95-rp/x86_64-apple-darwin/axp"
      sha256 "fdff749f5dcf67c648ca2a823388217a2e551155212f9ae279a1147abbdee091"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.95-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "68a4faeee364e5a1cba139b4aaafcbec74cea5eb0260a27c5b8e2a16315e824f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.95-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "2b20bfe5453f273df0adb1cdee9c1303e69c649fef3cc9f5532074d1f69955fc"
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
