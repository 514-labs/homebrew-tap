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
  version "0.5.23-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.23-rp/aarch64-apple-darwin/axp"
      sha256 "857815614d73d5292605f0757e26e87e6ba0953538c0d01e3680e939dcf089d9"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.23-rp/x86_64-apple-darwin/axp"
      sha256 "88327d34ecd1fbcbe1ecda9f6cedcea59551d16a8a6f6f67d3211cecec7d9025"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.23-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "1ad2ed4a2fd8ffda8835fdf190190308a5e431febd1309136d6845a14ac85820"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.23-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "73fac49a9e401810a6510bd10cbd7c909872a3710eed19346edfb9b3a2022844"
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
