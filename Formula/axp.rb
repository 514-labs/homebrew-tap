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
  version "0.5.34-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.34-rp/aarch64-apple-darwin/axp"
      sha256 "b714c11c0c512a9353ddf489a8a2083fc6ae1099f6c5d9cfa294b4804b415257"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.34-rp/x86_64-apple-darwin/axp"
      sha256 "80d8ba5bb0fcbf3052a10c5859c060cb8baac66de88518466848803cdb1a5eb1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.34-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "fb69c3b5507622c98e558846fefa8359b6edadc0a6d1d928f8956e4792a39c82"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.34-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "299024be051bd6e2ac064f62a903b708cdf86b89363e45fbb1ad6e0a0e18b497"
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
