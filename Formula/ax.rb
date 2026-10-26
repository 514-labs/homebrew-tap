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
  version "0.5.1496-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1496-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a587addbe0b45c526c5215a0518be8fdbecc65a4293d52726faa20bb467f962c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1496-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "752f9d26b472fff002ed87fad3e03133d0566104cd8ae3c67b7bddccbf201f9b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1496-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5011214c968d0ee91877d9eed58b9f9d6c7e392fd05354b1227afd754f03c2a2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1496-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e43aa6f77e901e6ac7f108991b5a776dc0ba92c18076fa247de70d4f46d5a1d4"
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
