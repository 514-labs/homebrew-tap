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
  version "0.5.1685-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1685-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "77073245e576688468a4d69c994f325d233af05bdeb50f76cd2f4778c668e09e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1685-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "17e0a8c60464f213c69c5e04b0e70e21227b517c394a36450cbb27fe071e7291"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1685-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4812e86d9c7e1af70927cd34cf9556d9c73e2a2ea0ecc4e26df9d55c001a90d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1685-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b08ea20c0a2ae909f688cbf01d8817670cec92d08c926e4ad268123d1ea925a3"
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
