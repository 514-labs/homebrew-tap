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
  version "0.5.1368-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1368-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9807be1e08e10a4f1333a6444920ce984fc42ea24f9e1f008ea1f8e7ef44be51"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1368-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7e9faa29caf8ca794ef018b2a1f5b6f752d445ad50132af5d0b13f0e81a7a4ac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1368-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e5e830a74e58d5f12a777e6ce2cc68df6478e40f9c2b2ec790f0aad96b2a1e4e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1368-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cea1b43f09adb4943e79077e29f3fe8f02f51f01c26a0964e21afc31c316e62c"
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
