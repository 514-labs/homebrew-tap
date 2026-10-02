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
  version "0.5.1241-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1241-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "896e30c5c9ace6a7bcb0786eb1f35db770627c27684e18a86d9121e73fbb145b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1241-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "566ce8fdc056ba5b8525ab1717441f75aa8b9b579ee3728552838c19af94e9a7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1241-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "05813ff131b1176c033a4f89730d328745cdb7eac86d404049af907560df1f94"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1241-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cdbf797c2544fe391fd302217a596d407aa7a04cad1fff78d5888c94ab0e15d5"
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
