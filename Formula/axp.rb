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
  version "0.5.1520-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1520-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d355b31fee0b43311cc2cf39c8ddf0cf377d17b0e0fbb742f81b88f30446b0a2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1520-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8a2734b594046b30421e7d7a41e4ae5ab364b136785bf661c3d6517e03db9aae"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1520-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "aa25b825392f38e85f181921b36d892abb19975b0ecfd2957181a2dd72283b49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1520-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "327f27cf884e91bd40e78ff62af46d2f6b18e228e67bef8b7eefcd62b9ab922b"
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
