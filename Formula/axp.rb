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
  version "0.5.5-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.5-rp/aarch64-apple-darwin/axp"
      sha256 "4220940c6873e4706053c1b5c6ed5f2e16e4ea23cf0ab99b4583e960945e215d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.5-rp/x86_64-apple-darwin/axp"
      sha256 "ec396f6ef98fdab37c3aef68ca3527779cbf57dfe44998f8578816221a4ded11"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.5-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "cbe51d03e4e20aa33fd3037bd10338a5400b1650caeda54a2da4ad6c5655a41a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.5-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "65a5f1368c88627d7d32b39e5136b0beb3955ac74d5749f6b5a11299ecc03736"
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
