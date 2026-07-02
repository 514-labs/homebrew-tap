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
  version "0.5.47-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.47-rp/aarch64-apple-darwin/axp"
      sha256 "96aa4f994ad2f3789b0cd46cec352a2821829344e252ca0affa126653fedab08"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.47-rp/x86_64-apple-darwin/axp"
      sha256 "ec399f03b975ec5c5c8ef3e724409d92c0ec873da4d6b1b34ebcb09b68620286"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.47-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "3b792cb306df10936e19423842e44e708597cf4447a7784c5ebfbcb5f9002b0d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.47-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "37337b71df5c8de7736abaf4a5c35f4217e7bed0619a3e455db5ea5691a7798b"
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
