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
  version "0.5.37-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.37-rp/aarch64-apple-darwin/axp"
      sha256 "49aa309977e95217703d60837b763372ec9e97efd27184181e5b5d1e11fdab64"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.37-rp/x86_64-apple-darwin/axp"
      sha256 "7aa0ab385254a3835332c838b6ab02530af0f7a4116dd748c4a73f37a12f6974"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.37-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "4fa7c384369396913b839b2f71b83bc2de45ab2d979143fd223607325648c215"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.37-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b76ef3687ba3812ca88ee5ecb0c37d82470ca8af7f71e2f9e0ef8d692c8a7e04"
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
