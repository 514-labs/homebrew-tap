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
  version "0.5.19-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.19-rp/aarch64-apple-darwin/axp"
      sha256 "fa1c09a59347641c8d13248ac3ddbf2ee3b52604f3593d38b7dfbf9ffd196492"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.19-rp/x86_64-apple-darwin/axp"
      sha256 "7b7c4d9973901a1c268155a4f518f3b2bb9569a7692bb73dbcce0de5d691a177"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.19-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "e781c9809c79cd3b5f8f09afbc8c60a49cbaf1ca6ca5069d32168708dfbdd8c4"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.19-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "2a45815b585a935ff3a526311388ddb19c3c3e30c7035c6fbc5e75479c0293c9"
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
