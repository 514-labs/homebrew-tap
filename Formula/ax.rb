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
  version "0.5.1654-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1654-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "39380fb42291012f988b6060325ae62cc8b151c8c2ed22d892c9b559fdf20973"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1654-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f65b32178a1b0f5f7e2a118d9dddeb0ba5a013ad0bbada4d00d97953e835477c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1654-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21a251c6bc051c1be3e8557c24b2246d7facfa18185768e54dde7c5ca0aea7f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1654-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e49bbe94ef058e35e16e126c538bcb4690d0a56348794a48fa05803cc1290a55"
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
