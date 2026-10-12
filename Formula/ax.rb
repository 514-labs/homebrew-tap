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
  version "0.5.1327-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1327-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "60c6f280cb022eedb0a26d6edc8cc1141dc2f490577b93d9209299de1c88f4fa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1327-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1671080ec79e44c573d830fe7228393193af88b13c27f7feee2910483b71d7b2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1327-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ff18569f773a2205b59ad9dd4abb2ce2e1aaf3e2f53e54f11b1f4ac8b490f8f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1327-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9fdf78150fa7f7c2ff29b66ddd312a887d0c1716ff4f059cb733b57c69f0b996"
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
