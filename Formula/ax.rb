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
  version "0.5.1335-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1335-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ef1c3bb6a8824582c8504f3faf3043f8bedd5ae4d596a8b4116b23c495c66c8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1335-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "714763a79c711a844842a5a989d57dbd1e6ce7254f201df90cc9b6e87cd17243"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1335-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "16f5e8c911568193c242cd2255801435273846dbbbcdece73cfaf9cd9f470bb1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1335-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1f0606fa7f18be99bb038c9c3fa681820ea60f28c48cd0e365e8860fe733c499"
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
