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
  version "0.5.1486-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1486-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "875e747780ba6b56bb2373d232ca614ad3d87d320981fb501b21389beec4f241"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1486-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ce8d495b32388e53fe25aece73f54cfd67e99dc9ffcc1019b2707fdee11354b8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1486-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "807e1f67e7895f5cd592ba787178523b07ebd8b00a454cd84bd76895555c5584"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1486-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32fa3f83fae902c4cee273eaeb8ff2423d82621b3d13747da2ee8b03910125f8"
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
