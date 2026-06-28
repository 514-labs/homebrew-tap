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
  version "0.5.29-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.29-rp/aarch64-apple-darwin/axp"
      sha256 "f4fc47728c0163e0c33315875cf1c116dd0e760494924de407e442d00b6239c4"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.29-rp/x86_64-apple-darwin/axp"
      sha256 "afa6f6d23845156f0efd0138bf191401a828d458bfe31574cfca65986d725616"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.29-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "9cf7f304f26a72dc2afbcd30de45582d2ff0f83ed7d30f53e922d7a88f203ba3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.29-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e84cb5ef5c8328fb254ed5987810d9fd403e916ef00bc8301914bdbb0c219502"
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
