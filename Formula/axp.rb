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
  version "0.5.1657-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1657-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d949b774e4dbd8ab75d91f3690eccd5df0e32c9e76580e905203b4001bdee2f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1657-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "32710ef28661bc0b99df6066333e3400381b24b213a054b2e8a6c728ca03b17e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1657-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f1989a19ba23cb955892971c6b3eb754db9effa1d6b84cff6fc014badbe06e98"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1657-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5040702f21e8f9ca9fe1828a3cdd28bec274be109bc1876c041d55a175d432ad"
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
