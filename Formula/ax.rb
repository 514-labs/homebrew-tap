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
  version "0.5.1472-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1472-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d0f48b5bf3265fceff4761bf8c94bfee6edd45c6aa68da226687eaf5d49007d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1472-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d02834dc3afffa3d38d87e4a99e7e71cdc26583db6261f7effc78159f1d4de22"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1472-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "59ca359435a80d0431b1c194ef24abae04faa317d2876c6b5514c9685453668e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1472-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4cb5a3875c20d60765448ca8dde1ee5f7d011cc4fb1da72d0e08ef8a76359b05"
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
