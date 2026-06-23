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
  version "0.5.10-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.10-rp/aarch64-apple-darwin/axp"
      sha256 "c4f68a403aa880914aba96444847e2e3363b22b140289a6afddd3d37813bc94a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.10-rp/x86_64-apple-darwin/axp"
      sha256 "3b216b690d320e9a9fd29bb3bf2b1df5df9b4e3645d0ff08af653ca93cbf771f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.10-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "2451533cc5dde0a2b20e5673413da66942d97d238a6eeeba2586ea17a477212c"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.10-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "11a4c826ba1574166896a31af8bc779028e1f721593a869e69b15a599391f399"
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
