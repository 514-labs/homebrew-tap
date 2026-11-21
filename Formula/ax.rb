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
  version "0.5.1774-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1774-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a5412558052ab1f21d2a9629f63966877c21a0ce78c5626903a851a8c70dbe5a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1774-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3c63fcb3cc9b0a7344daac47403fce92cd2f5c40aa3bf3e79bb1113a305b37bd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1774-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "195507458ab04ffbdd92c086435a444371e985bac0052934b90db85325c0a411"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1774-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ec02632817e5ad045f655957b848bbb0143af7cb15cc13bbc76e6f4984a98430"
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
