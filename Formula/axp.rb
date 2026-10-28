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
  version "0.5.1507-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1507-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6cb00bc188174058d0a99abaa8cf532db1a6e64d6cd770a6af97aaec3934a0b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1507-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "67b33d6d687add400453ab4bca0e736e63308cc5e552cb56e2fd71935990baf8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1507-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bd260f574029ef47b6f7d733332672bbb2b1f75b0b8b8dfe7792a9f03d687986"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1507-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8067d78864d7e65df51887799974a57ba527cbd1a83486591e7472ccc5299f7a"
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
