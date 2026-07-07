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
  version "0.5.93-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.93-rp/aarch64-apple-darwin/axp"
      sha256 "73c14ddf671e38daf86b98ccc97833c6f4f19b4d2f35d544243cc9bc41fcc56b"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.93-rp/x86_64-apple-darwin/axp"
      sha256 "c01925ab873deded6bb8ad426e3c734c99ff541402450f10d7fa9661d6b36ead"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.93-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "37c9fec44a6969cae246220cb4e99e150f3cca54952cecc63ebdc75d90302e31"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.93-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "03045b95f0325fce30f0412e5ab75dce0f2687d25c0e73af665a7c3164c2cbde"
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
