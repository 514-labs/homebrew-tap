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
  version "0.5.51-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.51-rp/aarch64-apple-darwin/axp"
      sha256 "319cb3d55b24e1236fe1e6213d7347b90bd7a2b5fe85493ac8b1567ab0aca8a6"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.51-rp/x86_64-apple-darwin/axp"
      sha256 "95e7914c7cb5e2215f979d58d14a8d902aed6c950927193a9cd6ecefc3b65d58"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.51-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "2cbdeac6e2c6c6fcd28cdd44a0eba1dad40272317f98392cb43de6738e8743bd"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.51-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "9530ca0b2acdc972988b737d955ab6a8a21663db8edbce047f560f7ec43d887c"
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
