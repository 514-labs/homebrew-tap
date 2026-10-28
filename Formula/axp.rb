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
  version "0.5.1521-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1521-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7a61b2042a8030109088f1aa833988518a46d2e15c3df347a4c0dbbf42221fac"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1521-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "361da5d46f227eba74748e96a7617daa2dcfb8f97884fcdcfc71b9a78dbdf2b8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1521-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3c47806a2271ee65006dcb83373f9f34964fbbd83a60c6284ed54d69b49a0b6d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1521-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ed3ad2d8b56d9c1da8b4d0840437a98c38c1baea14102e8a70d867b9226db189"
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
