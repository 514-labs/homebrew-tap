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
  version "0.5.1658-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1658-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1608f0aac16bde778c1e7c74c7991cf33d4806bba6dd71076e17b045fe8a9cb6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1658-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d76367f0549f85c3e9ffbaf525b6b3c63be3b0256907d284ae430b092b8d2129"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1658-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3b253238ce572e5d509f673f75d3cd9006ae0e8772dd0ba41a3612fc9231a103"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1658-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c71e57745dd525f71a2753715a9249b42acadcb883454ad147ed0a439dfa3008"
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
