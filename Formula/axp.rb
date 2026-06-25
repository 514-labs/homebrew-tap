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
  version "0.5.21-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.21-rp/aarch64-apple-darwin/axp"
      sha256 "3f633d5a0644ed8cfc6d198745aab6f73cca92bd209325241ab93f7f5eae9eaf"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.21-rp/x86_64-apple-darwin/axp"
      sha256 "21342c3d57d19ad75aae274371d4be2a161d7298f35e0ed78e0797c2aa7ee928"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.21-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "e8678b9c23f7d0dc1df54b93cbf02f3e365147014ebf8a1ea24fbd995f052d60"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.21-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "a74dbb2ec4df3d199ca67b5842daa4583ab462b79ea217b4de117e41a4916d83"
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
