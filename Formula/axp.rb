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
  version "0.5.1647-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1647-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7b149aaa741b6849622f4fa52a6120171f2fc07aab4095a074275f065f0a927a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1647-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ea804831da1eb6acce3e058ebd7370750845cd88d5c0dde5a9bdf58d4a823c74"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1647-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "873e72c9e7c9e7ed179dc2fdf9778dfa7ad201476fc8643665e27243340e5f88"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1647-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "99719b0a6ffb971458546b59fff1594d767f45f48770b480d837183c56957a00"
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
