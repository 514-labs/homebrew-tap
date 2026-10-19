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
  version "0.5.1418-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1418-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a0b6ccbd336844a6b7ab4eb6366f7fd0aec3aec2bc565d51c4dd9360651ac728"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1418-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "7f0b08d7bcab6edc0ff4a4538197e76d33b83b4a524090a379c6f0b899f456c9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1418-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "07fa49d9821d97c1b8df54a00e1d4a635db014a145650b39ad6128a75db62d96"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1418-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2e27c7113b098f5cb7f8207b52e054eecfeb48e51d1acc6f438e456f449509b7"
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
