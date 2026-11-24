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
  version "0.5.1789-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1789-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "754b961bee1df1376d9358c7f4aaf36d3a31f0cca37cb9fa8b5ed9ed34a5208c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1789-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "612478783481f5613b9b231f6d900b398cbabe77e9d0b07e522f0c2a05f35403"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1789-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "44cbc7a714b0be5ecaa0087e6e619dc1510c4a739ec7a1c6104639089a104c8f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1789-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "41f1d0e688913756d57b6c5afd6ad5b497baf2f7c59dd718cde0a30150e075f2"
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
