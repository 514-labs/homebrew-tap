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
  version "0.5.1520-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1520-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7be02d91c8287d7aebdf27de00b64e17a9210ce7bddbcfefbfff4b7a20a69363"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1520-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "cc078068b5391ecb7e9492134ffd3b015f04e8cefdb93f5c6c9876fd22279b18"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1520-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "01d86b264a0590348bc92628b7749f601e28141463b9af70fd1e962ba72b33c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1520-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0802759c2c088ce173f5f87fb9d5852b25425336cae3e4402c59c9c822947d47"
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
