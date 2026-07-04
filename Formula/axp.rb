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
  version "0.5.62-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.62-rp/aarch64-apple-darwin/axp"
      sha256 "46e31e8c6413ee19f1f6ac2bf649d6dbe8fdbda6054d2946a4c1d1b498ebf69f"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.62-rp/x86_64-apple-darwin/axp"
      sha256 "f97cdd37f9bb66b7096ca7a4c73f96fb4583931c562447f8123ed13aa24fe84b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.62-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "6f06229dc38ddf82dd040dfd8a962b6f9205a2ee12b3e7a9f59bcbf975dd8167"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.62-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "7382aeef60e51668fd65ed713ab9b23324f47e3a29f2836c79cd6198f58e78de"
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
