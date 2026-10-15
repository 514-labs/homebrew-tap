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
  version "0.5.1369-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1369-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4abc545575bdc0ba6780369e19011cc2f630b99f03bf18099c4d4157ecea4ee5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1369-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "43626f161df379cfd6bcb2e702196ea06068e6eedd920dfa1ed1ef5182c24290"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1369-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aae93322a3c30fb955a7a07c6f988ae3c0ca0e5bc6c9badb5d4f19fc4c781690"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1369-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a43c1fa2be5c1ef82c49fc4f71f548e032f0b0a276541f3e570b9514930bcb36"
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
