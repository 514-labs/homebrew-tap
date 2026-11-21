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
  version "0.5.1779-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1779-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "30193debb5bbb6d918d0a8bd8cac3336e3f267ec01dea1289e778d64071feceb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1779-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c00702a0c03b528cbf667c6cf83cba21a1b6b4b828768e37aa98e2a9b970cf8b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1779-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fbcad4981857590632025beb61fb1d4b3d75e29bfd489eb36c6cbf4b747cf268"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1779-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "36fa0d29f25f80e27f0fee10654bc4b0114e708b5beac15641ba385c0dee6561"
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
