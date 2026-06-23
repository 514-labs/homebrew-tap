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
  version "0.5.12-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.12-rp/aarch64-apple-darwin/axp"
      sha256 "b69dc10134b942fc47c22a00bb0da7c177546563979a91bb7b8103612d3c12ab"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.12-rp/x86_64-apple-darwin/axp"
      sha256 "a821df8907419c0e8ceb7da00b43bc32aaa1295634e9abcb5751a9b14428fe91"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.12-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "429cb0e44233ab0683a8c50ebd0460502802be520cd25969c44e63ab17bcf1f7"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.12-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "0408c4ff7e74ceaafd5fbb2586fed761a16716a40ec105b892a2459df0f7856d"
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
