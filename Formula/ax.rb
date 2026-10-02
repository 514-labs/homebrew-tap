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
  version "0.5.1234-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1234-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "27bff2b58dc4a8f3e0351321fc6db6befe345a4257680237aa9d0ec7ea5cd2e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1234-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fad25ddfdfc6f5079a65b1e12c8b3d1ff580479f8c5ab7ae565075a15bf243ff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1234-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c075eaee98ea790e6ec03ce2e5dcce991d46cf20367a50e8b211b7faad013b1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1234-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6022587292b2eeef86afa5baf32332cae9c9131142eb4fc22375f1b32a1d1cf0"
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
