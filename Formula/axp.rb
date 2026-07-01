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
  version "0.5.40-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.40-rp/aarch64-apple-darwin/axp"
      sha256 "2000e613ea46726b938ede2785a81f3bbc67fdc000b479db5a4a306a8c3cda49"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.40-rp/x86_64-apple-darwin/axp"
      sha256 "a83327596c82e9c240bda40c02292f8e3f3d509ee11fc05473d4955e5a6107a4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.40-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f4dd24475e2191ddd64a02f76d372f01c75b1161df04ad48593dd9a2434cc82a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.40-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "428cb000823976c0893095c5be09c18bc2f9fef2f45a43ba2dc58460e57acfdc"
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
