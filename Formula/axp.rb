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
  version "0.5.1428-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1428-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7614cbfcd47e540fe710ff351e6ae15d09fb4d59be027623aa5c6ac90c9fd415"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1428-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7ff907d0e70c0cf25e2381f7aec061137629ee02e7c73f9460fc1504bb738464"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1428-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "fcb1885606070cf8076cccd93aaa6e6571603963423c9c62603566b771c8a87a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1428-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e81f51979de9659ea638571082ce49b04420cfa14a3a47c47924bca17d8fe6f7"
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
