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
  version "0.5.31-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.31-rp/aarch64-apple-darwin/axp"
      sha256 "3adb1c623a06f14d0a6d332bbbd292e8e476c6963c3bd583374d1b3a50e3bbab"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.31-rp/x86_64-apple-darwin/axp"
      sha256 "6db3defad57c3d78241c38a3a5463704ccdc58b7e691b42026a894de4b243add"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.31-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "de363e09340af67a18dc84af29e0d56909ae9c330096fce451b8ec98a6c4c4c3"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.31-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "5cda31acd4f9626f7c6644a8ebf032c0e720bb36f8cfbe92e8899166a6808a6a"
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
