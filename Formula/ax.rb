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
  version "0.5.1503-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1503-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d5dbc7a672b105343de716f3073ea73f2996cc4a98c1d9a9dba1b91e66279965"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1503-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2c4fe3bee9b270d70951e19724ab511890639c7d83189124f0d75eb509f908b0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1503-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c5040e14aa00089cc6dc02d62cf666d85ef5928e1909e1b22b284bb5c6e6e0df"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1503-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2abcba165bdb7606a008ece3dce48900777e488c7e8ce455fdf7eb6f2cb26908"
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
