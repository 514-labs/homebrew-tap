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
  version "0.5.1546-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1546-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "acce6fc3c38c2d77bd1ed49b652ac2f5be391d395a686bebf7f07b0b410a3138"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1546-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "411441e59991480f9eb7032bd032f906fb534e7ed14d22aa3f629adaa67ca751"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1546-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "86f3b39c9e1c3cba017ba742fb4ac2270f78a1ff4690d5be564a61454e1c73c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1546-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "95f1423c95e6623bf5903efd42cd25cd97b207430da59fd83797308a68efd145"
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
