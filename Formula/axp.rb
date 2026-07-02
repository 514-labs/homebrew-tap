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
  version "0.5.52-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.52-rp/aarch64-apple-darwin/axp"
      sha256 "9938201d2fe39af4e9d4411e22bf2bf969489eb5ef69fed70c5581aae549fdae"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.52-rp/x86_64-apple-darwin/axp"
      sha256 "428831398d93b9538733dccb1bff348a0d6cfbeeb2f20ddb2e4c7373de737975"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.52-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f7f74b29a69270a3eea9f8453feb3b7770fcdcfd68848157c0d3d42bbfd1e47c"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.52-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "8c1fd31c2bb192a3aa0bd1444f224263c58e3b041d966798d02dc11f35d48cfa"
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
