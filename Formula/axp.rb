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
  version "0.5.91-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.91-rp/aarch64-apple-darwin/axp"
      sha256 "334068feb286a27471ae4299a1b431bc8c2ef03e17eb3b1c080d55d47ecc2635"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.91-rp/x86_64-apple-darwin/axp"
      sha256 "eb368e29345b9e4095af1a33cf1b1b8b1490f5aaaf4b26886e4b8444da933471"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.91-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "85a0938132801e1caa512b5676ef290080eeacb3b29fc0ad90e645fdac76ac9b"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.91-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "886364babc897102d1f8a77a52af7df072a098a9629ea5f037f179a2315784e5"
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
