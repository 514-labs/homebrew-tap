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
  version "0.5.1479-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1479-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c7ba9a86ae8de771866d59d3c8fdae78ff49ba6519ebc8299fdd9a065afaddee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1479-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f414cd6892a1e41839dbaaf42879955e7f009c86d99c3f46b1eeb697b6b5e839"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1479-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eda0d4ec39c87be49f40ce872103fbced3d8ee87f95dbbab977c014f6b6ebd7a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1479-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9d95a3eae65273e41eb2815f3a80041ef266bd69f63df42d8e4badaa97436664"
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
