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
  version "0.5.1440-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1440-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7a753c2eea32260280394d8b5f4d4408a02cff188ab33b3aa12fc06ffd91899e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1440-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2e1d4f75e81e9fe1b0d926de262eb7e4baa951eb708c2d888c622176580e058c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1440-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "56e27a372b580bf8b69e8fbed214ba6786599bc0230422c1806e835a3f6c9ac4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1440-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "02c5d7221f92231c5118d8de94ff8703c47fbf00d2fcdd3eefaff6625bb4c48d"
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
