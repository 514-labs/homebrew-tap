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
  version "0.5.69-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.69-rp/aarch64-apple-darwin/axp"
      sha256 "307e00d3c7a91ecef0b8a930c657ecd3d6bacb80ec87952465ceeba92c6abbdf"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.69-rp/x86_64-apple-darwin/axp"
      sha256 "3c7f42f866e9cd8453a5a24bc35e283a8a5af9b2bcad652692b69f1a502c4ab9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.69-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "8198b16e1f30bfbe17168052047ff63339a47c885f71b209a49884f47df46937"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.69-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d07c8b8fe9b681c4b8b7144e3a1bde86c1504d66f6349f28dbd4f52f0a106c0e"
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
