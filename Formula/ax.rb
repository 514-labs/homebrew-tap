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
  version "0.5.1259-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1259-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "546c3ca92dbf3813a4bc188dad929a23fa93a4a212f50fcb2666a0bbe05f6abf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1259-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2ba484d8fe23ace01ed13c58eb03f869656a11f24bfa0c108db7eefb8f221b50"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1259-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b8d77691c5695ee80bb3d1b9bdb67d842d0b1961a0792fa39b7dda38be06e771"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1259-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e0077943e8b38744717d6873e902e187392aa50a64e581f67bf2568ce4d66f46"
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
