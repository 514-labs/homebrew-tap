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
  version "0.5.1237-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1237-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1040b866446cbb4386dadf9574e734e33fd8113ffb8972fc3440239a1b44b8c1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1237-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4daca5e383c3b620e4b92788be42f83e320f05ec88bb3dafb585dc0ad25832ef"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1237-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d1075355332d1c6b127485c02bba7fb8abef6e0427cb5d31d5100c57fe8eba42"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1237-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "45305ad5b631a776f75ad51ac822af2c2dcb6742410ac84b54123981d004c12e"
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
