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
  version "0.5.1746-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1746-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1ce7986f2774dc3f427b43dc5c6694f7e772e99c38ec11bab348f0f2bd8e12df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1746-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ef41416181cf94f278f45286dfeb209aaedac80f57f511cba19a23a1ce99c41b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1746-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39ada904603a86d3ba59e29822731db39ec279308b9b7ef62d90817ca4d07278"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1746-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "583630c5f0d5757bf0fef75c2883ad4fabf5203a3f9b5e2e663306497acf1c24"
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
