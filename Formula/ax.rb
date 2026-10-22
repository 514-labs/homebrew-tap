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
  version "0.5.1467-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1467-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fa82d1b246824c0e385c2c174703c2dc243cee80ab7a18b7e420b23a4d76d35b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1467-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f51e3d6f53cc56a4019067f0effd5085e2125b084502e465745b1f8abc9802ad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1467-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "23dc4e88e903b5ffeb71c048227ce7afbf9d0a5096d36b111826a67464827100"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1467-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b54b2a5740de0db1b5a5e6c2c03f7bdce9eb15d3fe3341316ef92104b8c26c90"
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
