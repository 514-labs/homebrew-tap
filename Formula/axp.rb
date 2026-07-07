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
  version "0.5.98-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.98-rp/aarch64-apple-darwin/axp"
      sha256 "0ea1d823b1532c10fc2ea94e7a3406e113da037dca34d86a68703cad66d11657"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.98-rp/x86_64-apple-darwin/axp"
      sha256 "830b29e67e7ddb2de8b59acdda38f9375132ac1fdad77ce33b788f2cc4c72a58"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.98-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "dad136a3e979b7143e5d5025380f87bb2b143cfd2b0b91c1b4cdacbadf96fc87"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.98-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "c92b366a79f1495701596293a1aaa7b4612458b5f25b3a97f4ab2e5b2cc53e8c"
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
