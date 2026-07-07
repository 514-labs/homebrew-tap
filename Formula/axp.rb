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
  version "0.5.100-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.100-rp/aarch64-apple-darwin/axp"
      sha256 "dc315c52d4e1eb89e78cebb2afdda78e021dcdefae33bbf39cc3c10bf859a133"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.100-rp/x86_64-apple-darwin/axp"
      sha256 "36db9687423025a7cd18e9c02e43ebd7edf17143d6e075b141f07524215c0c94"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.100-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "0dbba2ab28895403c1d8a5f3bd7050cd89648d967cea297493cdd9e747e2dfad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.100-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d452c2a259584ff8a4722d96dbb9d409bcb40f92861c5c2d31fb1ac73020a9cd"
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
