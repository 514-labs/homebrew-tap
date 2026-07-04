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
  version "0.5.65-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.65-rp/aarch64-apple-darwin/axp"
      sha256 "1302101f19f72c3e810115ce8cd27f80c868052c547cc5ba5d993296a327a30d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.65-rp/x86_64-apple-darwin/axp"
      sha256 "68b153459bc797ddac9e82a74b9657949a6a5ac7c42eb373cc0985d2b1a79379"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.65-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "92220a77485ba8dc2a85acc0d30aabd611323fe4569878d52c2f20b56f94b8cb"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.65-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "28488c6ac883eb1b7cbb216c4d8cced09aec67618eea3f848ef6c4c21f16b5f6"
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
