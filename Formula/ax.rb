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
  version "0.5.1548-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1548-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "66fa591ecc64d3de07a044ec4907a82a5446c6cdeb6efc53803827caa846414c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1548-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "05be0a1d536d88aca1d2d47a0c3d43c454fb77c8d3fe900a348ca069f1d0db08"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1548-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "17f58a9dc6f1266dada993f9db8f5753f2a8ef34477ed4c387bac584cce8a990"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1548-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cbd51d38ce9d2769cda83a61c4cc7c86f4e7df854004bc747c013c1de60a55c2"
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
