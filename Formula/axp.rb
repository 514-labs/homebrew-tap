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
  version "0.5.35-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.35-rp/aarch64-apple-darwin/axp"
      sha256 "836875bdca013b50fc127df25137ddeac1878530f01e0bb02f7c54e47937bfaa"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.35-rp/x86_64-apple-darwin/axp"
      sha256 "36da1172b955e9abaf2d849821df4dc5041085245513df1c5497c8fdb0bae2c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.35-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "4a8c21b81349312d1d3715b61cdc548db0aaf76a5822a9637be67f5d2391242f"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.35-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "dda82cb58945772430e2cff996f508f597a0ab9ab25e100ae119734bdb368506"
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
