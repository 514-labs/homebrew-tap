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
  version "0.5.1239-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1239-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5f209580aec0d7278537fde7c657c406cd9f2b7ddccc5ff063d9d0c00efd52f6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1239-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c3e953a12b55c76a663f4f0102f2d27aa25bcadf0aaf85528cb3177a787eaf4f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1239-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "61bdb98b25b9f000656c47a721bd12482ee78dae47ae4f9cc775fb7a9a2ee3f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1239-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c5e83cfef5a38b303cd3621b6ed0c747115c0bd7bc68793f528040bd30ad1a9c"
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
