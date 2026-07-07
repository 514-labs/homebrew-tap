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
  homepage "https://514.ax"
  version "0.5.94-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.94-rp/aarch64-apple-darwin/axp"
      sha256 "da699b06c5ca4dfded55c2b40ee580dcd42f169801773bb407b0affa788c814d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.94-rp/x86_64-apple-darwin/axp"
      sha256 "d1af5e1ba68ce85937d028a17b0a55329fb33da8705fba9b981ba32986fe7fd0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.94-rp/aarch64-unknown-linux-gnu/axp"
      sha256 "b453d54d3d2742c2db96ad9ae84d29d3cec13c1309166e1f0a03b4ceddddd666"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.94-rp/x86_64-unknown-linux-gnu/axp"
      sha256 "29d42e008b8555b0653e3f0d73e319388dfd8576d13caa44b66e5bb1cf9cdd3e"
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
