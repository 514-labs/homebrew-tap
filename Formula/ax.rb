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
  version "0.5.1669-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1669-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "293b404e060f7ec4d0d9fd3f0607441e8a58a8098cf6646923816390905b44e9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1669-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "82b20b2b3e3bff0c8742039e71479240ad4696ab9265a13decd4a96925b62f0b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1669-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9f82b7b588ebbd0ddc73308a4cb41b0db262188a0619714d588ed211c825c31a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1669-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7d3f88eed33879f7320831a08968bef7bf59cabda7a54f116f2e672ae9b1faa5"
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
