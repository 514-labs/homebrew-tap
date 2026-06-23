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
  version "0.5.13-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.13-rp/aarch64-apple-darwin/axp"
      sha256 "bf2007a65aa0dc775bb3d7ea4b548d41406a1193821dc1ecfcaec0406b3f3845"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.13-rp/x86_64-apple-darwin/axp"
      sha256 "bea42817f04132d842daefd8d468efea05edaab708412077d3835088b997d802"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.13-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "e9a89937f461c5fdae35d328ad327a734bf75beea8bbb5b53aa3b1c32e27f731"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.13-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "c6512fb24e469e902a116a44e5af2956f269a00c7a448f9801d536f1d7c074cc"
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
