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
  version "0.5.1733-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1733-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0467102710f456c7bf5c0aace86b613de6962ffb60776b22c45af753bc1079a4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1733-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0f756b237b2011b91f26d9101ad4da1242c127977ecae74b4372683eb8c85ce4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1733-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9e821d76c00e2a8b1961c2adbf38d88df6ab0d4fe072929bfd8f9ba68b4d8ca5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1733-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c6031843c78b1228c7e40d263e3e5ec15db85610cd6ffcf6363abc35f3494b99"
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
