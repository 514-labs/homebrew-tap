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
  version "0.5.1256-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1256-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "24ef79d0228ba1ee51301e230a679369fd465366c828b34fdcd99c96848649aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1256-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b641b179843253e015ed12630ceb84bb84537e62b4d3d29fc039a64e74fff3c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1256-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "921c6f3ebea4ef61b3c3890bead045bf1abf328c8c8580cd4cbe1b397e9c5c76"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1256-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0252986f69a48eb5062eea48db2b4abf6835f6bc322ce6fad6f4b41be5b304eb"
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
