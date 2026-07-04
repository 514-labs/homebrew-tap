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
  version "0.5.63-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.63-rp/aarch64-apple-darwin/axp"
      sha256 "8c3e79c35d566072e8278c9975d9bd1480edc5c31e8b0c9d2beeaa77966e1b3c"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.63-rp/x86_64-apple-darwin/axp"
      sha256 "83f44cc01541e075ecf48cad0cae47c64ebe20f3e9a02f3c9db9d7f52570b59a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.63-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "0003c22f22a90b2f4b38138709fc21d944e00731a2fe3fb4a88c5a7fa70a4d04"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.63-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "665033e848b8753b60de7dfeb841060f51c95bbedfc1f6cd2bfcda857dcc7b8d"
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
