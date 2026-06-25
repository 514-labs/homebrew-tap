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
  version "0.5.20-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.20-rp/aarch64-apple-darwin/axp"
      sha256 "65d063973aa2cb21ce901293ae2865515176b71d5a5c112d2afe3b3860d2b3b7"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.20-rp/x86_64-apple-darwin/axp"
      sha256 "464509be1b28b5a9adde15f6673c71143c6a4bba51f900fe5e80fb2b006c42e3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.20-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "4dcae0ee12cddec892119e76c3cfe9701bdbfcff3c2a7c8eb4bc604d8d468912"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.20-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "029826283dbe9fce4c0d4feb9ac77a9a4121cbf7137b4615bad94e6033fcfbcb"
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
