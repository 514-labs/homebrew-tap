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
  version "0.5.1371-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1371-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "17f93b90da369443edca45679e08904f924ec33b16e9f5a232f8e35cb54d20df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1371-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b77ce2bbaa28dd17e75be4a3d7356ce638f732bdba578f22a72cd1f20e6210b3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1371-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6e6d2d04f0ad2b4006b82af3ee204ac67548e5f5a8993e45eacfcb3c3cd09802"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1371-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bcc11b17f18ade84503e543cc0a458569c3e03d6e8e15d7b81d0a3b733fea64b"
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
