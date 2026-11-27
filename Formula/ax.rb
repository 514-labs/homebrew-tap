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
  version "0.5.1801-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1801-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "33a328b6f3492de6b2b719ffc3acc88801cf331b737522f26259f67449232573"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1801-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5a177c50cbc738d5f49331922f81489dd5d7f796681f8059c5d144d54cdc643c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1801-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4f4e57b7fd9a62b266c560ec0f5026c27246214f0aadfc391a6ae8e51f884aa1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1801-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c45d15cc446c7bafae18cad0b5c67a5bd7029c285c73e0b52b64e23c0ef9b0a3"
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
