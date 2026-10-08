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
  version "0.5.1279-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1279-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b0382e73d0711eef3e1426a12ac9f2830fd4682428bad5a960200bc49475e934"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1279-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bbc29d97714e7b119d9ad7d8035d0f8bf7057cd82333844b97f377d219ebe070"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1279-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "34f3d1e32342f6eb859d0284ad36b79fffd08521054f9a1240e4ff08b8b1d3b1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1279-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "53c9152c3c8508be28de0d70e8e276b86fb5ac9fe222cacdf0ff6aac8698d6fe"
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
