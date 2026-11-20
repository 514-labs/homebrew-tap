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
  version "0.5.1770-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1770-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "eaf8df23ed4c730a348e04abbfa547675bb3aad2dd150d3a0e4daa1a439d50d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1770-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "bef69a4e6f09930c4c1ef8a96257e9d59298e30f6891b7b1cfc6007abc3e95a6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1770-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "32620e6fe2965a661a49041ecf530258b7ca04d55868be81d7225373116dc6c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1770-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7baaf63128ba0ca2b127b498491616ab26c3fd793c8bc02a932b488f95a11a9e"
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
