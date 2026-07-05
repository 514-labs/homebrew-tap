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
  version "0.5.79-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.79-rp/aarch64-apple-darwin/axp"
      sha256 "0bc10299d550395109555a0abbfa1dd602552e0c95ce5f0839482fed1aebd817"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.79-rp/x86_64-apple-darwin/axp"
      sha256 "d26a775fd87d524f1d0c5ded160aaf2d9aeb49fea651940c5aecfc9133d393ec"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.79-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "68346b95c9f4d5317de7d9254a84c5665aaa4624224b7aedc20a62e7b4e361ba"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.79-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b65fcd5e7767a2117d6a9c984b137f528513f1400869585187402891b08b633d"
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
