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
  version "0.5.1435-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1435-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c9ae391c01992f85035d2c69ec06b6cb23fd32906f31e63a296d4ef03c4b87de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1435-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a4f427c0e21d7ebd7c3e1ad3714b42c9a6dbd8458fe7b6d862063ea3922ae775"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1435-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fc805fbb373bb0b0f2c4e21b10e854970046cc233b510a9c1b1e96b1d8d669b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1435-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cfb0b59f31a7144da7f030da83d8eea2a26c3fba3a0cf9437ff988520fad3858"
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
