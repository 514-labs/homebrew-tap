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
  version "0.5.27-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.27-rp/aarch64-apple-darwin/axp"
      sha256 "28ee1a0fb0c5b980f3aab8b103866abc18907f3fd818bcee44db3a53035d6aa9"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.27-rp/x86_64-apple-darwin/axp"
      sha256 "8dcaa88527a12bb59858bd9bdc6963d161d0522580abda58db023cf7005fb1aa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.27-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "fd15d1d2af12e0d75fcb17e15c630620891bb250f052c2e8e19caeec367430c5"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.27-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "97aad9abcb4f9994e32d9ff93511ea535cec54e1c6ae23a93f243d9164326835"
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
