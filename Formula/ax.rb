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
  version "0.5.1370-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1370-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bb45305e96ec9cc883229794cfbdbcd5cff82c2d35228db47e48318461b5d4e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1370-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f6b603d5c74868d53da8b5cac4cc644adbda65ef5e804e251ab9478784e04668"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1370-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "961c880dd878f7f504000f9818e4828424974f7d7e56261d23a035cfc10dca9e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1370-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "30ff1c777d3fd5b65bbcfe99778c07c473e73025757aa8776be8680b7596e4a0"
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
