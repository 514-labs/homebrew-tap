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
  version "0.5.1254-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1254-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "55bd83f21c26891184877dc91324b12ca505ab3176b4fc429fd81e2da8a64613"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1254-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9f0904f09808e97f6a275ce59922ed942885cc861051537812805e8d944ee810"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1254-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7e34a2b31d8fd3121b1a6c7f7ee1aba311ee40225ee7a1a25da19d671f82b68a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1254-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c0ff3e412fd6796e8bf905e0ea846f3a0b78fd08744edc3a537cd8931530e773"
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
