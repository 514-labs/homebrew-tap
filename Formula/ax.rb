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
  version "0.5.1432-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1432-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4f21ea338e8c7b0d012c0690f3970604a821f17d6583fc0b8a0619e02a5827ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1432-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8d078fb19e4a77335bb9b8645346f4eb7c3e33c91b10cbe2fdb1fc4c121f5120"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1432-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7bc45f182b5ff8971afbadea5d2e971b0300b4c7d082f49270e0419381e04788"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1432-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f39b771eaa15fd75829ccaecb03e56c6ede4e4b7a07ebcf274ac34c48555761c"
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
