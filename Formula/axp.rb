# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1321-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1321-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f0422b7040a62e7dc89cdaf744d2ed743d596035eb164fc36b753920988a4a45"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1321-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a40b23184bb9e9e91a26feff0ad273a41ffc81e7eae04993c1767ffbc1e0321f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1321-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "304b1dd295b7122a25a8cc596255733354ded9efc7d8797cfb01284d0e985002"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1321-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "96f61c34c941357b83f7e3d19548fce0d594e0d000211dd71e6ab5508a15028a"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
  end

  def caveats
    <<~EOS
      Sign in:
          https://app.514.ax/sign-in
          ax auth login --token <token>
      Then get oriented:
          ax auth status

      Next: create your first experiment
          ax experiment create my-first-experiment --template cli-install   # see --help for the required flags

      Learn how to use ax: `ax learn`
      Already have experiments? `ax experiment list`
    EOS
  end

  test do
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
