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
  version "0.5.36-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.36-rp/aarch64-apple-darwin/axp"
      sha256 "af6e10a82545379a97d32614b6eed36794e3843630fd082b4585d7c76b64e054"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.36-rp/x86_64-apple-darwin/axp"
      sha256 "d0d2b990a89d749e583dcb64e2860a499fa7e7987212dbfdf00e67f0a5ac9454"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.36-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b8a4443bb141b70268c9fd297c1773616f4bdafa07bcf08e25b9f9f178202a79"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.36-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b02a7ade49c3f85d0dae0c09ed56962b73ed6e31c96f592df686c6d83cc2567d"
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
