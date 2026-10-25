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
  version "0.5.1491-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1491-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "350cd9976b9fa7ea7ed2f96c9f7b629df8828871d5316819bb66d844127c9b67"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1491-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f788a45dc1b55c971f58285f8348a7c22682c8bad8891aa29254503770a4f028"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1491-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a1b6b4ffde71f01a9fdff26adfb6d4547006e721fb76eedda89694fe53b75b5b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1491-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "91869d643df87496df2359201e50e08b843669be51c79d7592f8a40154f04ff7"
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
