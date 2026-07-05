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
  version "0.5.76-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.76-rp/aarch64-apple-darwin/axp"
      sha256 "86e768c29427e84e4ba06a05051d055a81c1b32973636bbc6569afbd68378591"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.76-rp/x86_64-apple-darwin/axp"
      sha256 "2b2ff7f42f9753ef8d520dfa166818114314834913531bba1306846a64443f3f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.76-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "de2a3408b83d70dd0e20eaedfe1a59849a53496de2120223057fe5857ebf3596"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.76-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "aea202b5bac74f02c0fd0e7c418ac3337ea86f6b24cd6717e0458456ecbd305f"
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
