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
  version "0.5.1721-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1721-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5bdea08deffa6fbd40d62f86fe5dea9c24533366b6939e559fc12a8e7881e46b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1721-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "421d2a042ce860b90eeb80b120417cb32a211c83b0c07e87c18e922db5cf02eb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1721-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "84009d4562a1b7ccf9b80502742959e3f4ce68514e06365050c7f8b9f63da330"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1721-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "11292c46aaa4140793133cfdc24fa069488c70379add2bf1784674e32e880353"
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
