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
  version "0.5.1369-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1369-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "354ca58a01831b6990e0248298c5c1ff65390690cabadf50257145ba3a7646c0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1369-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7396137e11fc0cc3cfc1d3ce7d86a26d26d5a4e6dd1bea51b7b7119037ff99d8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1369-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9d40089de8dbcae5d21fa6e66fa971492dd917b07f161fa499118a9e8b586b59"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1369-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1f44d7b530098ae20f09f9e351dced0db074a8c35abe6a5916e7b9f2f6bf429a"
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
