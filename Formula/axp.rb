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
  version "0.5.70-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.70-rp/aarch64-apple-darwin/axp"
      sha256 "8e373534845d5a0fb82dafb78b1cc2a7b197580805dfd80188166a99c271840a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.70-rp/x86_64-apple-darwin/axp"
      sha256 "a25740924a2f1ca83b5e49a6da60127e29930728fb608cee91553d2e81591dda"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.70-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "3060b0cde7f70a8f544c95466470ded4f72d6ba9b74c50250822377baee5fa4b"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.70-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "1ad83d1d95661c41a502948b6bf632b1adb5c011b0e31be401f40bbfcfea6e76"
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
