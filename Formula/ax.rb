# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1476-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1476-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d5d98873f2c2be749b975bbbd88d8c55ed97b786644e7448b313749443f4b5c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1476-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "96135761717c0383040e278b3ff09308b0bb915eb3244177d5579eba3c4a45c5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1476-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "925dba6cb77f2e62b96c69f20823ce6272bf4b08684e6d97a29624831c455c58"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1476-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f32025f2cd2f80d29346d869ecef7afe2268b283efaa0b43ffc334417a3221a0"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
