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
  version "0.5.16-rp"

  on_macos do
    on_arm do
      url "https://download.514.ai/stable/0.5.16-rp/aarch64-apple-darwin/axp"
      sha256 "96eebaa92d876883a82826ae01b0b015e0af6325d45c5363dfb5af2474c80c1d"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.16-rp/x86_64-apple-darwin/axp"
      sha256 "584f2ce5033f1d944f80563e001ce69e00d2fe408559d838c2404452f3437160"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ai/stable/0.5.16-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "a527d78957a475f973fe8280666265012c95a51529c72c03305c1913fe21c5a9"
    end

    on_intel do
      url "https://download.514.ai/stable/0.5.16-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "e22937055ba291edad9ca1e30e6b42014535c235e669964a674b5b25db7c87cb"
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
