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
  version "0.5.1512-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1512-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a37ee4908ce5e7b7cd3bcdbe159f04b4cd185ff52411f669e7a59fe8e9367dc2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1512-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ca2c388199474341d72ffb9f8b50742a254269d87ebacd0690e28338a044bdb0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1512-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ac7baccca94bf47ef641ba2c9bb8a2369d0b298b703de99339d32e7dfea9437b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1512-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "14f4cd2c1770b75a6d0cc49f3bc3e739fd404ba840aa1011c2860e3a09b8a6fe"
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
