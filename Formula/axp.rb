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
  version "0.5.88-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.88-rp/aarch64-apple-darwin/axp"
      sha256 "f97a9fb510a35a0af3d6fe392c524c372698ae9d5e50cbec32a9862ba3212d94"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.88-rp/x86_64-apple-darwin/axp"
      sha256 "9527521ce84fae4c4e72e5f0e90f8fdc113ca101830b7a9366532ca45fc83605"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.88-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "bb1691dd78dd33866137159673635a536ad92384ae0922c0cea78a43e03b876b"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.88-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "c3ce5d64d5be29daa51bb5b80d0395d6848421753056f2285c4b328e605519cb"
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
