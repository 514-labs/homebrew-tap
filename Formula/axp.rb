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
  version "0.5.1436-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1436-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2ff21d22bdd50c1170554ca014cac49ed3c53f5fccaa9c22becd87511d942bab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1436-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f396a76b105930d6108f939814fc71af4f1de92e8c3ed873401e1d230b2eed2d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1436-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "762a7b6d62f2e4bb04e9a78a6e67db428f61a4b541173296b8958b51597c93ab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1436-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "75f1a89c2a86baf84a48d0d6e3c698d1aa0c48335980399b4c51ffed7496c9ac"
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
