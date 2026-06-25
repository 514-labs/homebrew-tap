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
  version "0.5.22-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.22-rp/aarch64-apple-darwin/axp"
      sha256 "1b0c1284578870968a06fba3cee2222a7cf74b35a8013b818bd302b53f5f6241"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.22-rp/x86_64-apple-darwin/axp"
      sha256 "f7de1688b1a792b851239df486ac7a1ddf1ff268a242a26520cc75e0a068955e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.22-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "3d11579980237907e9d2e31fe9b60287f96e30a903f0d1b118f2939fef9f8574"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.22-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6e2e82e0dae801d011ab2f135e66aa23f47bf29c066cbb7654c771116cc39213"
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
