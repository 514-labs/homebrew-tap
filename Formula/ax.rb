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
  version "0.5.1637-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1637-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "66b773481a7df6f000f67c46b40d5251d4f24e31799bde6cfb70f6ad937e23cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1637-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6a571d8b4eb61d23d53de2ecbb6707434eb08bf9697966481190a027e5e224e6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1637-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1fe46a3d0f62d12651d74076dc5723fc7c3a0920b4bada4ed72fb06e179ca797"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1637-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4649376e64d44992fbdac4f3b50c763423058cc597a05a64a73bbe307bad1d73"
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
