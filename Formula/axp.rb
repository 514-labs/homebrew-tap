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
  version "0.5.73-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.73-rp/aarch64-apple-darwin/axp"
      sha256 "bc0d699923a2b668941938b58814379022036dcb3f7b81467ce7847abaae2cba"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.73-rp/x86_64-apple-darwin/axp"
      sha256 "1b5f3846b63dd648ff72644c6d29379104fa9e717ab3542253b5895a3177b48e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.73-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a8dce8be2945752d3b74a88162354f4860e287b340d450c2ac0b46690173ad03"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.73-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "70c52f751b0491e22082a580ba3ab12ca771b3fa4aba95d50727323fb0d1b2cf"
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
