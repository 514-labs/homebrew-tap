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
  version "0.5.1469-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1469-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dc96fd3f242716c29d8338d234fa8cc5ecef31900bcf0892182ff71ce5704dbb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1469-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5ca160ae1b38af848b56fff9ad48c8c339572374674f4c462139f9044f9a8fac"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1469-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d2ef7777f8a6dea3efc4be015e61d76a255053c55af2009c1e386b4a717ef9e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1469-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4570b1d2af10d965fb1ab81fcb28e22478b4395207bdb776136fac605a1506de"
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
