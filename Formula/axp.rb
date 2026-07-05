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
  version "0.5.84-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.84-rp/aarch64-apple-darwin/axp"
      sha256 "6c0a6fa6b95a565cada0905d593d403503bf55b20db43fe71bd2f79735c719c4"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.84-rp/x86_64-apple-darwin/axp"
      sha256 "1d9d7c14bf7cfbd56f4f2959f4fc1d009940e7cc0a9efc00e552a54908a78905"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.84-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "79633a3434456926e06f89a3d9a9ca6791e680ba5bd090c112ed939d78569f52"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.84-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "be4ad83354a0e7bbe0bd67de2286f3bd22b256fb12910ddd424745bf2e5adb1e"
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
