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
  version "0.5.32-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.32-rp/aarch64-apple-darwin/axp"
      sha256 "7e52b3983603f88278d848e7080125af897aac43d28c25abeefcd0f2a60094d1"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.32-rp/x86_64-apple-darwin/axp"
      sha256 "76b49aeb450f7b8f573b62f328783c4b4af86ee6535cceb8b5dc8f8a23e573a8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.32-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "776383f0ca6255bbd63804bcc12fe67fddf84f041bf6a9a80f7ade8f07763e31"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.32-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "7303a737b43b88d810fd4008eb7c2ceb89ff9dd446dc023fbf5559d21af5f782"
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
