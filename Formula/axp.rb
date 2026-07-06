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
  version "0.5.89-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.89-rp/aarch64-apple-darwin/axp"
      sha256 "4da254721a252eeed8f7f1770798bc0f6e93cc27ecf52ca02d2d7d906a66f4de"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.89-rp/x86_64-apple-darwin/axp"
      sha256 "eab08ab0a8208e1266bef34c7dd05752358907c7351d05e5c7b22c12e4215ba1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.89-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "dc61219dda32e4eec3d93dec6092d0bef3718a8b49c95b333de1ae8a62b59434"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.89-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "7cd4e73128cece36f61a0ec34cf3907dab522d5646fbdcb87c79940727fcbf62"
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
