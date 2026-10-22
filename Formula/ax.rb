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
  version "0.5.1466-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1466-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4f2f49c6d8509fe93fb2ebdeb5e5afc09caaf7c654e749a83d8c4f0a9354ef01"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1466-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "399b0f6687ee92ff30bd11cf424d6b25e16f6069d0ff593e2ffa079ec74d8f6c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1466-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e590170bf1e6260fae3df03fb1a64ca6c112250559f071dfa6c0de3c08a3b605"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1466-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d52daa24e06fe3a3d150283487a6484f85293c31611a272e09459df04cd30882"
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
