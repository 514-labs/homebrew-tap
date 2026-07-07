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
  homepage "https://514.ax"
  version "0.5.97-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.97-rp/aarch64-apple-darwin/axp"
      sha256 "462894cef590a19e06fdb1bdcb0f41c0d7bc59abb6392576c303f903ed3b1af7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.97-rp/x86_64-apple-darwin/axp"
      sha256 "5092807691840171698af9dbf2f55e773c3a5f2738743f2d73214866562af325"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.97-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "ead36ce8f1d4a6efda1d9d17603989b177a3d15ecd446f19d75f1a066d9bb852"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.97-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "bb5b63229c656acdd65b870a5d6f9077574a5b59b389e7fe5aeace96f5ba0a54"
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
