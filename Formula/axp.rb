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
  version "0.5.1406-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1406-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6806a0ddde9437fd1b460c90c730c3eee793bd7f83444af3b58ead8ad5ed2a06"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1406-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5764fc0d5466d956cb9c6ecc7d04274294fcd6608cb5d349ca7a53e1e0e5d79c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1406-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6dde86fc4d9a71f5f8d148f61922e74cbeeba51f343472ef1cb95d06f9900e32"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1406-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a238fd4c94fefc7102043fe18c7ed4a3ee2884cdb16948e72f4d276bf5325f02"
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
