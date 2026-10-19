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
  version "0.5.1416-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1416-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7095b33b5e4500dd54aafff245204d1a99f8fdc663acf1c9124d05da53d71e32"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1416-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "566ed015adbb0d11514f49071a1e7ce18f543ed7514b354c0f375c8ebb9e6072"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1416-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "110beb176ab94bbbf1245a8c071d6854c7f31bccf072f40f6db7afa09ce651fb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1416-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "480badd0caed33c33a6d364828a88a91cd0dca29e1df3fcd986269b08e181b9a"
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
