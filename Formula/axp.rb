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
  version "0.5.57-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.57-rp/aarch64-apple-darwin/axp"
      sha256 "29af275db5d9e196b9889c2cfb798c9a4512f99a3e896a257f6b090b41aa241d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.57-rp/x86_64-apple-darwin/axp"
      sha256 "5ec0ddc5e8229750ed5691d86b0069adb3e36977a64910950ba16de37ee113ce"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.57-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "26c95ebea2f6ae570b541fe4cc3c220dd892d92ed873ba186ca3004008423e2c"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.57-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "21adb8f08200cf551a989e81ad415ac5657acb47bcae78cf65a569837d30e161"
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
