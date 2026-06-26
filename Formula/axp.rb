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
  version "0.5.25-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.25-rp/aarch64-apple-darwin/axp"
      sha256 "e7a2e1fa0e526745d5545c9eb68e0ace61606efe14abb9cf65d661c8f583bf52"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.25-rp/x86_64-apple-darwin/axp"
      sha256 "0edffe267b7029fad683c07ed7f2d1167aa44573d6997b6d9160006c1dd7977e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.25-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "4429f07883daa3308e316cfb34c23dda02188872570557d90729df19c7f86735"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.25-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "87f83dafc123acd1f778b7705228f95f27adad6e351795af1499411eeef42761"
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
