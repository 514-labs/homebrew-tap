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
  version "0.5.64-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.64-rp/aarch64-apple-darwin/axp"
      sha256 "05084e626575e7a454d1b570fb24f8b29f7925009ae0748ae5158386af49b040"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.64-rp/x86_64-apple-darwin/axp"
      sha256 "a15d43f54dc320562507b7e788c4f65c07e3910989d78a0dea02341eb185569d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.64-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "3d8464c386d75f8c2cd2231956287590b6c8e4d02292616d29197a84efdb5618"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.64-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "154406c7e6f8b3ab64538d0c935aec3c5a8c2a9e20d346705393b1147549c5b5"
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
