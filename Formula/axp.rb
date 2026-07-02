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
  version "0.5.56-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.56-rp/aarch64-apple-darwin/axp"
      sha256 "294618c2038fd094af509e062cea6148038558a3948d164f069aea1fd5182094"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.56-rp/x86_64-apple-darwin/axp"
      sha256 "04e1bfaf80f5fbee7b244aad52d7ca3acb9afc4ef8448a13045d9bf0146653a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.56-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "41993bcb526f96efaf31e59bcee2bf0bcac74fe8672bb39fb4e46d0546a07ee1"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.56-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "686de5e7d6ea20a7931699b07bd965feed435f125868caa18a09be049c5c446c"
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
