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
  version "0.5.1480-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1480-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "35d1549fd04d07509d270f605a7f807d7b73d1eb6970123a9f7c863368e794e1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1480-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "136f68b152b25816e27a4e15b9fa72a596c0a20b235338a6e04d99057f110ae9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1480-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "db5c12d65fa88902ce03387d4d7c08194b6e10cf233382581a587d28ae682fa8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1480-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1488b738f016e0e6b075b76cee4fd93b2ef9c059dc4bce00e1e76576fe5cb93d"
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
