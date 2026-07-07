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
  version "0.5.96-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.96-rp/aarch64-apple-darwin/axp"
      sha256 "a1a4d5a4e669fd52e175f1982d9aea628448811986836f43e0399ee9a4ab753b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.96-rp/x86_64-apple-darwin/axp"
      sha256 "983cc0d3a6bbf684442583aeb7aaac8def60a798e0faaed02ca3ba6bdc81be61"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.96-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a23913ec00e1abf6d34abf0eb6c724587f83f06fe91b14552a2aadc01aa1ec07"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.96-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "9e9998560f9a70d73aa0ad912ead9a68531793ac3d99c4da9a84c8cb7928e8a3"
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
