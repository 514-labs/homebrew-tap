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
  version "0.5.1464-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1464-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4328848190bce64e77aadb41746857f838556254a0307c11756189b7cd21a9c1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1464-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "04b5aa3c821b1d4e0537502823d4a9d90810899b2d62cfbcf6986e05ec5f68c6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1464-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e83a658e2323b42daa319f8979d078b7461ca9018586ae087496f7a6999860cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1464-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e0d9931ad78a32b6be1650fd5dfbc431e406bc556457e0fb297c732136df47d0"
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
