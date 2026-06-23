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
  version "0.5.11-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.11-rp/aarch64-apple-darwin/axp"
      sha256 "15a5776f9a5c66ba9e1790719a2ebc9a1f9e335d1b87411908c4940d86183034"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.11-rp/x86_64-apple-darwin/axp"
      sha256 "3c47d97d760c4b579c9f1f8a586ed722745dfe151de5d0f1e8e6b74a5a7a6e40"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.11-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "f38936900cd84b7917580376137add7e9e2f0d51781644917fd95aab2744238e"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.11-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "ebcc6929474d7fb639e6d4fb1bb08c7ea62f8fc0883542d72260ba895d2bce69"
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
