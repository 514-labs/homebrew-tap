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
  version "0.5.1751-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1751-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c1da76dcab6a28e5bcc892baa2f6b41047532db9d1cfd14c088fa98787b07e4b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1751-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0d99d0e36f196ddc85705abe9a8ab4d6fe4f4419133447400c5834da55c19433"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1751-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "066c3c4ff6605810cd6cf650e70b9581d18f785512d6f14e1a3437b4c816e55f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1751-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b5d0c24526e3bdb3adea13cd91948200e18ef83b178780b3ea2fa02c1ebf648a"
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
