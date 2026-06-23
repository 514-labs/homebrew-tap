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
  version "0.5.9-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.9-rp/aarch64-apple-darwin/axp"
      sha256 "fea66ee01b328f1ae54d8780eb58501e7a1f7f4624115db95e6d5e53b3e3969c"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.9-rp/x86_64-apple-darwin/axp"
      sha256 "bfab7a46fbb15f8e6cdd57056f3f02705d27d2f925ee7c19438eb71077ddc7a8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.9-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "19fd0af151e4ef8b31e7d4bddd9e91eac3143b45eb2d80f2510e4e801e91343f"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.9-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "d3db461563bef4cd1e9019c3e08dc5252041aa5f112bbee180cec20a320df1a1"
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
