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
  version "0.5.1772-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1772-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c28a0c003a595585a388153d322d62625cac22de20297d767cb63c4254fb6ce0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1772-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3c9c63e08bfe619971ab5a42bc039770df8101c58f9b3562a032d3e5ee2ebb1c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1772-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c66e9809a7a20c79efcf19f6fdf147f9d4693c0866cf74442c9951c23ec6033c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1772-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "701f04f48d68df31ff84e73e1a6d005cb9cf4ddbc6ae6d4682775ae45b9e6ee7"
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
