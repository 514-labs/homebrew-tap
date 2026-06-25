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
  version "0.5.18-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.18-rp/aarch64-apple-darwin/axp"
      sha256 "e7349818b8c4d3e794e0acdaefd02c7d2e6b8ddaf3b3525ba8337e432910bba9"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.18-rp/x86_64-apple-darwin/axp"
      sha256 "09d0d7ec83cc21dcbbf9ed2697e8fab735f1396187384b12c79c9de6ad979ae0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.18-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "adf8d131c0ae693045b1259d5794e7dc51b17c6743c3181106a71a7092274f73"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.18-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "54d8e9fcfbdcb5e4e5d8566a0bdb9bbd9c86c3087831913005347588265680da"
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
