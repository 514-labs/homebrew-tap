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
  version "0.5.1500-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1500-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d1b43273c2b0fe271113bc89d37691cce019e7c793af83ffe4991fc1aa4abd5e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1500-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c0e2636fd28cfb7cfc462bb8f9d9f1f8b116929159edaeb3314cbde57058dfb9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1500-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cca06f51388a735b0ba2c0c5437ca1109e8101fd1bfef1471dd642bdd977ca2b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1500-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2fd5663e384fcafd21fbb2e0ad6d5a3e9fd6ab81ecf6853a4cfaa18fd877d049"
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
