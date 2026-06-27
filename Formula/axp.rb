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
  version "0.5.28-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.28-rp/aarch64-apple-darwin/axp"
      sha256 "e1527c7843ae200d779b6b491b308598162312b93e6996bfc128bd5e16e92616"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.28-rp/x86_64-apple-darwin/axp"
      sha256 "ce7410ce439634e4f44d86ea4aeef917165dcde17d1ed7ee3e2d8ce9ba7021b5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.28-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "d500bcc1ac7275ed865e1d60f9fc98ad23bfa95679ca34b6560c819df0e82c8a"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.28-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "922839382ea619c488c06822d3e3b7e06fa56ca9061972fe4c2315f58c381e2c"
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
