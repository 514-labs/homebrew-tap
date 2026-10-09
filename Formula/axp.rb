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
  version "0.5.1310-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1310-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8d0a3c491e3bcd98db4b4ee86c376e3ac70331094e30b6af441079e4bfa1ef3d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1310-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9b069fa7d064a9a98c2059dba754ac08b03fc398c3cd6726b12b7cd345ee9879"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1310-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a073af033dda2e634d5c7b226213f98113c072292e2f4d2c390f61b6c9bb6b91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1310-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4c02e5fbb3823734246e7392d3f08c88bf51f2122a6cd591264f5985a0d652fa"
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
