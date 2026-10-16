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
  version "0.5.1393-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1393-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c2a040130814ab19ef315f79f63e621b65cbaf04128012e401a7cacdb620682a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1393-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f526994bbfd210ed80a69c40798b0ad1b29e9220923fadc80fbc6d2b90bf77b6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1393-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "977000ef1733300dd0fde667ba9afa82761d9865d55eb1660cb4bf70f83e9c4f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1393-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cb3574e2ff7e3d8cd8a787f16bae56740c5bae5e7e19b950180e7f0902116874"
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
