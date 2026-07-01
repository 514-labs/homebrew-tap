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
  version "0.5.39-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.39-rp/aarch64-apple-darwin/axp"
      sha256 "1a74b763a87a88c21c003f9e12b5936fd946d28a8587bc1362893844f9222052"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.39-rp/x86_64-apple-darwin/axp"
      sha256 "e3e3ef7aa60b52c187f7882f445063368ad4109bf55f31edc6b76b7a3627b636"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.39-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "7509a3720c9ee56b44c4ea46c61015cf66f54ac7e25fe62ac915465b8869d3b7"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.39-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "9e1b00e5f963493bad1f88ae8bbce272fa717c29aba08ea39fbee25b1eaa1bfe"
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
