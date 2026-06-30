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
  version "0.5.30-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.30-rp/aarch64-apple-darwin/axp"
      sha256 "91296b01786af53e9dbb7ccfb56a0f1a247571ef61b2dcf29b430959397ebaf6"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.30-rp/x86_64-apple-darwin/axp"
      sha256 "0bca59d7192d7439c34e9953b97b79ac1af6e5ee66da76756622d81152708b17"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.30-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "ee40e69786c0fb9c07ae59259c43d50d214a75b373855be07c99353537c41950"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.30-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "b5a518ccbffd60c2361371e561b5f53570f1a58a05f8f881be5e35ea4ccf3ce2"
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
