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
  version "0.5.1359-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1359-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bea6027e11ef9a4556dd51eb7b514025f5f7a89215c19587321326460e163c0a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1359-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b556fd11ede46175396225ade585625ad2565bf52072037c9d9b617da4285bd9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1359-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e6ba757e5932b5c49c716e76d9a76abb1fceade3eb40d55437c7d75124e5c6a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1359-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21e2a316d62dfd46df8e0ed50633236330edfe8965a15de955ae8a9bc8a6bf90"
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
