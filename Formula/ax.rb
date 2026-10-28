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
  version "0.5.1530-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1530-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71489d07a570b8dc5c1c5e5a047c6a957feca43631a9992fa3390a22c4b382a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1530-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "89c97c4d0dc4fb9e8bc29feac36c88525f6a4c05536dc603ef4e7c6203b4587a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1530-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e232b3b8c9e31c46b476c3776781cb9b0a5b84c6752431f31bad1f5af6cf700d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1530-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f2add9e09a850323518dd284db7d43c5bccee8e1b39ba15cf178c96d8b64088"
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
