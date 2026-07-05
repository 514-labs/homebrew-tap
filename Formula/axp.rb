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
  version "0.5.82-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.82-rp/aarch64-apple-darwin/axp"
      sha256 "c0b6e2b3fed34bfd56e27bd725465dfff2c09d71be7f0b08333a90f00f8d670d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.82-rp/x86_64-apple-darwin/axp"
      sha256 "c175a735751f21da4018143fbf54e8808f054f56dcbd2b3e5ca14e63fd488721"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.82-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "2a310d1f4d800edc4b5431f61abf49d30205064d6bda5ac8f962dce06568a38e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.82-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "f66f70647d48d144b350cb125d8afcccca898901a2c96b0253d30f433d72e520"
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
