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
  version "0.5.60-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.60-rp/aarch64-apple-darwin/axp"
      sha256 "75d52d9f18f70970e56eac006923dc8861e590577b8c251cfa8fd631474267c8"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.60-rp/x86_64-apple-darwin/axp"
      sha256 "e4ef417ad720c6c0557176e192236ec6dbd0403d6ea9a9267028d1f13d3cde4f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.60-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "8b34a4531e4f279871e421bea0947088266ce0f912981ff9a2334880b4c463f3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.60-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d2cf4bd1bc798fca4ab9a3f00d6174da308792d1df8a399ddc1dcae6761ea607"
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
