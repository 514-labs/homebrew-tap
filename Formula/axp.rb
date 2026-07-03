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
  version "0.5.59-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.59-rp/aarch64-apple-darwin/axp"
      sha256 "74ef0299e16b0571ba0765030aa38349318da57173c2965f4e0362cb2bf2c2b6"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.59-rp/x86_64-apple-darwin/axp"
      sha256 "bfd606e095ffd13b8c715c374d1de095c1e699e87b94ad2cf6110aa501942218"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.59-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "886572ad8d2500041b680b5a0aaa49c36febde1322ee09cee895781f10b5921d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.59-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e82c123ac7506af0feacd51b0b61ef838cb641860ca01c0c4daad5a292bb749a"
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
