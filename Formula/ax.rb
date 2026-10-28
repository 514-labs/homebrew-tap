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
  version "0.5.1518-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1518-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f89321d8cf8315a6de158f52c1af0ccaa9c0015a65b9f1dedc5bf7c604df379b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1518-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d508d05f4029ab8b4af3ca338fa23c149dac9eb74dfc9706a5a8535d10ff48f1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1518-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "57ab119327ed54910ad9002cac7518368507206db44fc4a3fd447ff608aee22d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1518-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8162b9a80f1fa66fd7e785af715683662f754b68094f508b36bfbb073e7fafbf"
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
