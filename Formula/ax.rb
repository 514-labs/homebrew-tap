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
  version "0.5.1357-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1357-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b7b56569bf4e95f23078a8cfb2c1f22334e0b855c6cd50762471e7ec3f7b8db3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1357-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b72de8c0ee205a7b207bd153cb0fef31669a2a41fc25f10929c2ff48f501c7f4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1357-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d0ece55da54e9c5b185906d96d6670753085f1017f82c8ced4e7d21b8fd7b111"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1357-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4e04faef00c0f3f74b0ce68a58ca59eabf8b92e0fffd7460196c5a39ad760fb1"
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
