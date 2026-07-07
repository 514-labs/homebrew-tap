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
  version "0.5.99-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.99-rp/aarch64-apple-darwin/axp"
      sha256 "c638022f10e7d06823dc2e73bf9beddc5a9cff9acf3fc7a4bbc4f8da84bb4296"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.99-rp/x86_64-apple-darwin/axp"
      sha256 "f6cac52d5a2a692ca97233da9dac79a4fb87a828af7ec27d7f822da4c27e872a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.99-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "1848c95f3699b44c64ffce54c54fd0d3b27a927399c86265b90325d55d6085de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.99-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "75e4a1bcfa95a4d14df8fff59e30e421ec888eab82bf745ad2e1749152d486d5"
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
