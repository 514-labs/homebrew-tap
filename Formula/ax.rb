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
  version "0.5.1517-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1517-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ebeaa8134c069f2a0b5dbfe6ad4f4f4334f04a4564eaf054fe8a41132955f319"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1517-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "569612b074a19501a986f11aa2ebbea1585e8925aa98e721de8f267b8c879b3e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1517-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "65f3b18d2ed439fb533076c4a97a6b5e668d2c2a1159941c9a0cc29011f79a7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1517-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cb57082583b93c5ccfe3ef74c0830b137d93d5abf3d6a845ea1b2e5441c05850"
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
