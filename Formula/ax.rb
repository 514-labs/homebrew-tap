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
  version "0.5.1722-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1722-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e77dd3bec55c33396ca83dc53c262e25ced52ae6c2c720de99905327829709f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1722-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a8d009976fba81d2f04a3b28e20e4676228f69f0a8abe018f1e44d5eb88d9ad0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1722-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e72cc7390b247d769ccdd69380d3f35430d76f5906be93db78ae0fc3b0f97887"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1722-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b082ebdbba6ee7251b3751d3f3d2c7a928ebf1ad59ef79d67cb7d65cba3dce0b"
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
