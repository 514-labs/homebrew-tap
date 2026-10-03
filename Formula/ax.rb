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
  version "0.5.1245-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1245-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a18663638b9e02734a5553c478fdb1ab00a9cadd4c5b4a6b6b1d80f13aa5d18d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1245-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d1d222aced5c4046116df3c42bad36b6cd0964bf52e9f6b0ebd61af24e582c91"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1245-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "09b06fe211369d518e10fe5160352000eee43b49d4c99c804a36cf88a19ed117"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1245-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "22851268b3bc0b49dfb76e0ed38558645159673024b01a5818d5d86f59322d48"
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
