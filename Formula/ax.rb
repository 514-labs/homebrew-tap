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
  version "0.5.1262-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1262-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ec956d4220b518c402e07507e6aa9efdbe79df180f4ad4e6ae0c60397bf442d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1262-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "15f75d6e7eb8de7e5eeccc18e969da84f442468b78874f209ef829ec69327052"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1262-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e720a3776e758d2eb87575227e661f71f2eb4755c1dfa3e8b41fb2b85a8d2bef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1262-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7ef0e83eb1b6172bffba93fe65ad33ac33b5ec38ddbad702c8367b0871960e07"
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
