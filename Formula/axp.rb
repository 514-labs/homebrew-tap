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
  version "0.5.74-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.74-rp/aarch64-apple-darwin/axp"
      sha256 "61cdd7c10e6d7586974be589d56209d562a99e63fc9394b9ab2797547595f866"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.74-rp/x86_64-apple-darwin/axp"
      sha256 "85d8e1569f82600e1cd46de583b01432ef2107d5368fdec41974fd42ee31d168"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.74-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "8e9a6bd10c0331d1ea115f853a209e6e070e36394d2ff800f1d19523f7809a92"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.74-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "76bf0a255cc00daf8833df6dae47674c6ca5ed13114a6fc4f3208226876770ce"
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
