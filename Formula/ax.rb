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
  version "0.5.1686-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1686-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "704a51a120563f7a3421f30f5d674b0626282c3973fe1e29cdbc80ea72ce4abc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1686-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9430e901cb7a9abfab1b58291100b26493daadbc494b79829266e42dd0694c91"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1686-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ae2788ea920f15d2605428d451697ec6b0f6d4336c1f75350aa209b6a9bf7ee0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1686-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "db99d9be954e62636584d87251cdfba18375612710fb4a3ce35e4949872dc643"
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
