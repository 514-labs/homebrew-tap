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
  version "0.5.38-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.38-rp/aarch64-apple-darwin/axp"
      sha256 "1387890ca7d14af02be8d52210af6490cd3dc96ef248a899ef5231adae095ad5"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.38-rp/x86_64-apple-darwin/axp"
      sha256 "e85a11448dea4018500af6f153a3f17b3802866e3d6588cdd4fa52c53d047679"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.38-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "3baf12e11fbb19130be983d71d6dbad157d869b9fa10b53d0eafaea05bfb635e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.38-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "f2e11aa7f0e7140a8aab7b1643fe25606e0111ea7973ae1c29e7d9ae5b370947"
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
