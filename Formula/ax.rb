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
  version "0.5.1478-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1478-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71dfbcbb55935bebf249beff28fc14faef4237bcccb76e855c79c7d2808e765b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1478-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f62419fd1dd85bd772fb189c042de6a8f4fecdd446e3e4079c0f9e9587f60c2c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1478-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2455a7c6f2de1d2d0fffd95ec38d826a969e14da75b9b326fc8be7d4325fb91f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1478-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "01b53ed285abc10ea78b8102dd30befd0861e5bd6253894f6acfb0c3dccd65d9"
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
