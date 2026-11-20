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
  version "0.5.1764-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1764-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "74b66bc4a2de45c7cf30021a32b0b3f1ca58899e31530b52ea0e6bcb7e6a5ca6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1764-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e5bbab9983dbe9dee7d4eae508f03a4f43872cf804da27a4df356ce542515ecc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1764-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "12bccb5d04052a2cd166a4d60e5aa9db4185712a491f8d64c2ceaf1a9dc64a79"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1764-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3be96aab76f34c7241aeedda91a010098af2b315488ba382359f5dca761316b8"
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
