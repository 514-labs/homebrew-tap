# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1366-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1366-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "356b9019fb41d7c4020a43b6047c6ca16380b5794a4b8ea4c402a309e5d85630"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1366-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bb19a3b71e65b1e0111300723669397a514cf16b46089c1f18d7bcdf5aa9ea73"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1366-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c8300428d8882b8e3b794fdcb41905c3cb262d7691c9b8061298290b878fdbac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1366-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "74b7adfdaf347107e32c0ac8b24fcf0517da30ab685b9095b6e66f257b331489"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
