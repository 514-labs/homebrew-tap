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
  version "0.5.50-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.50-rp/aarch64-apple-darwin/axp"
      sha256 "f5aa1569a6576d24206d743fc7ea9447f6edd66b559057e409104da8af60578e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.50-rp/x86_64-apple-darwin/axp"
      sha256 "49b9e9766854fbe4b9bd735eb4a2f2ed4277e1f06666a63d8a04c21dc4fdaad3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.50-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "68ee182161611749a53fa9517e8bd10eafe73167bf443dd669becb103967b3c2"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.50-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "42a99448822549883e2e860affbde79dd5eb3e25fca549ca05c046ca490b3ab3"
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
