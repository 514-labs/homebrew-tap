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
  version "0.5.1502-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1502-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b6616ce8c06c5ada86e0519a3c69bcf0da4214dab007662159c61bc120ea9b11"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1502-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1a4652e7c0e75904bb20a094267cfd1ce2ddfb25dc14a4025717ef0aba9d5fb8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1502-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1e404b6fc69fcce4bf048d4be40d2df804b9532b177f1e8eefcf614c7b025767"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1502-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f884f5b6106f1aa772777d9a37122f0a4bd621359c4d85e827f3a1e4b1841c43"
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
