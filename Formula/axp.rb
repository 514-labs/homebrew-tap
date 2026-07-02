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
  version "0.5.46-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.46-rp/aarch64-apple-darwin/axp"
      sha256 "3f0bf2db09d226361582e6e5a4cbf48d1d33234b12a8665366b4ef954562d452"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.46-rp/x86_64-apple-darwin/axp"
      sha256 "c64d27be63e01a60c9de97ef7614c146ece00f99c11675dfe626819a21d6b22e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.46-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "6602a507db0c89d985ba54ea480c98a12af79a155f139caf45ca8ae0d8996d4e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.46-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "42657dd1dab3f5142fc27e5810e38f354e70ea79477c97a4915a6aeeb15b169b"
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
