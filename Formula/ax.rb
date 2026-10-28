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
  version "0.5.1516-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1516-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8e1cb59acd2607f90b29d44a4300e11a89973c013efa52819e78c5b43b07cc63"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1516-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0d3f16d9998c90dee56bc5e1fdde17beabde92a1d96c06ddf4ee53a9cb8d5b8c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1516-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "90ca2e63e2d3475c8a04a6046b0c396431ad7de561ec3ce02c815debcf41bde7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1516-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cf34f90aa0c9032b3f246408605b1112ba85308917b87e2633a3cb47533393dd"
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
