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
  version "0.5.1544-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1544-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "85805b792a9352f459a2e972bc87b213d73c796da46f6ac6e2d467fc734c2152"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1544-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ba85c0da0ec2df61a4bc6fedc227468bc1f67c1b54abced9c54bc966b7508c6f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1544-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "59646e80949d679f2d74082b2cfdfa5f98432473d0e38faec0c5074451574e58"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1544-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b0495ec15f38c09c4ab5add7eb1cc1634cf04c20f020d83db4223d1467fa64da"
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
