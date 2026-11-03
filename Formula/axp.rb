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
  version "0.5.1633-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1633-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "228e28e3f7f9d79514bb02ad391485386e5e0eb76e93e63e8c3e97791e36ac26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1633-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0d5ba6d122be973463acf9452abacb6c97399c44bdae98b9641ba7b0c3fc1886"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1633-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1efcdaf0c2ff49fdbf2175588d6e5b9c1fc146c73d6d86333f30b4b43c28d98d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1633-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f16a21259d76294811f429288cd34811b613aaf5b5ffcc1db60360c5a91a4ba6"
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
