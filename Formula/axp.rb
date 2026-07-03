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
  version "0.5.58-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.58-rp/aarch64-apple-darwin/axp"
      sha256 "2aff0e48eec6d55156b1e44edc62694364af05d8464fc59d4c9cf0114f24b2bc"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.58-rp/x86_64-apple-darwin/axp"
      sha256 "db7d22d6698e6c74e50547eecb9e27580acda5f5eec66aea36bba0140b282380"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.58-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "030e58d8608f59ed3350bf6574771d13f80f80c02c4f9d29f3d850f7c1eacfb3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.58-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "dbc59f670b01473579c836be0a61131d8bfad0a6669e3c9453fa766656cf80ff"
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
