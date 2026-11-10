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
  version "0.5.1711-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1711-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "08b065b145947c3032d6049357640a6e237fcf1424c26dac85de3fd41a8ef1b1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1711-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1dd2304a225f41717662ac163d2a4ab4cd3361529eb4544c427933fd4e0a84d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1711-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "21f60dd541677a4385df55de857470cb8ff03a74b9d3fed20e00e600759117d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1711-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a280b2fd65fe7aa88d98e5c17517b36b23b6f35b2c201d52e21a4e962e589f40"
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
