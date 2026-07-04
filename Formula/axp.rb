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
  version "0.5.61-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.61-rp/aarch64-apple-darwin/axp"
      sha256 "1097e1b6be54c0576140b6706e9baf584f8430496862bd65ce2e90c49ccbbbfd"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.61-rp/x86_64-apple-darwin/axp"
      sha256 "f0bcb6d844a01b98b5e36ab8a98bd7758f0773653bce677386643f40de7a265b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.61-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a4e2afe62f45ef2072a170b8a2e9d5906d8f4edca61162af2b546cc28913caff"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.61-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "0045c5512af647f314086fa25c4683af0f393e1a7b39a10648cb4e4082224c02"
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
