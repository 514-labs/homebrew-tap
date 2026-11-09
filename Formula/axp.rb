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
  version "0.5.1700-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1700-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "bfed2f2db7c928b3534ea7fbecf5c3f000422b34d854a5d5492ea1d901d6e43f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1700-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9b0f8dc5a986a127fdaa1cc91f9a02ceb1953d3a0854018577b041956243a1ac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1700-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "02c05baa9447549aa03160d9ec2c24366267e4d67f154111e157f3b5d1b7c909"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1700-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e9a7ba2fbdb2c4bb1a9e6266175d5bd82e3a3d0b1d5076732e86f2a3dae8f3c1"
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
