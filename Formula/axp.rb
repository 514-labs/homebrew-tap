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
  version "0.5.72-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.72-rp/aarch64-apple-darwin/axp"
      sha256 "2e819db03e91bb034bca00fa99593efb3cd8d790f47513c3ea9800d3781e3156"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.72-rp/x86_64-apple-darwin/axp"
      sha256 "ec0ba493bbc99a3b57a1bec7fbf681981725c5f14f002aa88e312f9735a74276"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.72-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f7bb6ef8abcd459ba43b5f3b73782aa6e985f213b3bd9961e92377682a703311"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.72-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b0846eda36a190ed24ca2091a6b8a3d1fe7826489473485c99755c078599272d"
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
