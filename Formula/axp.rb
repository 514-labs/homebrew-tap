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
  version "0.5.78-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.78-rp/aarch64-apple-darwin/axp"
      sha256 "174dc00ce89704b1e42f672ddcb648d2afd09d861b5072808fd5fdfec27c212d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.78-rp/x86_64-apple-darwin/axp"
      sha256 "5998e84110b580ca6b852126035c7474b1f7176aa644134a0a32c6a37ab01533"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.78-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "02fdc565aa6437f45ffa56aae0c35413aa25ff46e85cb47492e54d5d1d802098"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.78-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d54fc476eebfb650c67642e6ca8207d1af429266a6e265a72f174b6316fe2448"
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
