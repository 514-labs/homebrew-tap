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
  version "0.5.15-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.15-rp/aarch64-apple-darwin/axp"
      sha256 "38d70712598256ae98eb0b20041eb394b738ce1f479d89f81b62dfbe7cee3b20"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.15-rp/x86_64-apple-darwin/axp"
      sha256 "cfcc330f4b6afe0f627feff75867f5c28253c37862a3aa41b0481dbc37fdb9ce"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.15-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "127fdbae73e8accda14f6cf68ec8acbaad656876ce765e5db47d5de8c70e9cbc"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.15-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "44c7e3b5edee5478d916518bc145ac451edaf492c9bfbbe4339c43ee7a29b402"
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
