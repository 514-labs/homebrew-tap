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
  version "0.5.1313-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1313-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "223ad6b4e3bcabbb5d5ee22a4f9705f350f84bf79780b9892cd0af5169887962"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1313-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1b1e47eb891e67e4f42480bd5110306c5523443eac14b1c5f3add7cb2d555a56"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1313-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "41d0a0f50e4804cd9d2482a8b635f612337a1fa3516dc50b1301d1b86a911473"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1313-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8bdc6b989aebaa51ba5d9eb0c82944175a9aa4ce5791472529ce30e14c12852"
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
