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
  version "0.5.1478-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1478-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d83029f450570b5a66654cd0401cb8919322a039af45883387b6ff9663557e73"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1478-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c63c3dbe081c323d2a0d6f9cd4c422064e5a527cf467b66c67b94bf54bcc779e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1478-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e5c0017d43c3e5547a9ae1e621dc7aa0cdf8b2e7ae89f739b312b275782efc03"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1478-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9bf3e0347443bf3c8170c7eef442279c7a4b6ebd26d55f2be38c81b27a9c9179"
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
