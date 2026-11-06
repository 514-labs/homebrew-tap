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
  version "0.5.1653-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1653-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "50db7fdf4d9d8fca8fe22d733c9fcfdceeb09b5a967bf55fb7eb5c0073dcd178"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1653-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1f47238559791fa09698a67e98bb795a47fe7d731a276736cc7eb57f5416469d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1653-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c709dc7211f8ed48c84df9237bf8bf65937b7f0fc7bfb663354932d6e5f76fef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1653-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6119cdebef0047e0e890bac9b42c6ae3440f22a5633deea59347489b5d8c98b6"
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
