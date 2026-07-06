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
  version "0.5.90-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.90-rp/aarch64-apple-darwin/axp"
      sha256 "b709b5cea82dd6ceeef9773b724b96c36390e7c895b6bd12441ff2b6ecb393a9"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.90-rp/x86_64-apple-darwin/axp"
      sha256 "9e812c8634b40827b4b6e5712a58bd0a4c36568add8185d7d193a9d37ec7089a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.90-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "76c5999f0401e712caf357af6aa2c28c70b074b1686572efc330d90619df0e75"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.90-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "5be0c61757f7072e8200dbd1c7c8edf7282d2ccaee93a0e5aa1291740a04b942"
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
