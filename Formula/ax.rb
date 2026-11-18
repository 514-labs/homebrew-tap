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
  version "0.5.1758-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1758-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ae6e43918d0ed49e1a7729b7ef04f6472f422b10548cf45526d6970d1cd11422"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1758-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "963cbd28375919c321740ee9bda5a36d3234408abdafff18889fc6d26e86ddee"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1758-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2a5327b39c04fe2b522ffa890a5d3b42e047eaeba9f93916e2884c26762a6343"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1758-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8417d70a09e7d23d39e4d5ef673b7fddde03f2751345a5f5e6c4201e3b12a59f"
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
