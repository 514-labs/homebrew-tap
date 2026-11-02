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
  version "0.5.1626-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1626-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5c8628d5fa09f23e888d9ae7928932396c75af4bd120fa5a165df512557b1467"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1626-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c2b37d1cc5d71961d8623f6c56a660d705fc21c75b3f819e29f77471d029c33a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1626-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f4fa22683265680ecf46c85b17c2d57201002a35d8beb3c59d8ae140149f7814"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1626-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2cfaaf4bb6c032977b377c1e6409fea7d0f8cd152ca231de1a9d7625477b5b55"
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
