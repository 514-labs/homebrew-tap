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
  version "0.5.71-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.71-rp/aarch64-apple-darwin/axp"
      sha256 "f66b38ac9cdc1991abae21ffc94c59b99efb99ca25c2b605a99056080d20b122"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.71-rp/x86_64-apple-darwin/axp"
      sha256 "8019a4b9285dc1c6e7bd694e78159737cd5b50f6b003d139c019e0376068ebbd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.71-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "8764fee961af35f0044cd67edcca202b678d6a27e0daf97e72f4ceb6d3b0c4ab"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.71-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "f17c6c6d1810a6f7a4c0cdfee9272f9969016349475c8fcb3b1c6d76f086006e"
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
