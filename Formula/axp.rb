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
  version "0.5.75-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.75-rp/aarch64-apple-darwin/axp"
      sha256 "edaf4885835c30678e4e9982645f6a559a517b85cd9c1f3cb5dddb6858605dd4"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.75-rp/x86_64-apple-darwin/axp"
      sha256 "821628170785c6152b083dcf3044d95f013ad81b29c1bdba1ccd819709a49f96"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.75-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "4ca2c0d63c6171bdffb1a7e29f0a26e6b8eb8f6ca370a23fec91d6a3f64b207b"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.75-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "76f3cefebae021c789a7e7038b4e71ace5f902581ac0d981858e5779ea227748"
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
