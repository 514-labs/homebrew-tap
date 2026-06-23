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
  version "0.5.6-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.6-rp/aarch64-apple-darwin/axp"
      sha256 "3231a6506e75688f16d813e6539d5d60393dc3396442ba192aa809e7fb4864d7"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.6-rp/x86_64-apple-darwin/axp"
      sha256 "f57f474164b24eb3e3f0d102d3a599e8b8ed3303763a302735da3ab9362cea23"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.6-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a8176d2ce3df2fad850775ca00323e96c21d28897fe8a103707306e0dca5ee60"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.6-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "6636d60c4e6ada2654cefad40f3e20561c507f4f319f9581dbfec72697dd80b8"
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
