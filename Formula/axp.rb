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
  version "0.5.1458-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1458-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "4bd45956ac622a220ccab12c1c5429de2705202f19029b59699ee9a8e62d6556"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1458-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "98bee5ab6d44133b18d8d7ee12e09f655b8249b3c8e03f16847b13fc2794712c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1458-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d7bc1f1c085d8e3e219520d223844878359998e590c9c6b535a43cfa428f5348"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1458-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "46b5a7c7583cbd18e863192fc182e22c9ad62fd911cedf77e10cb2d326f931e6"
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
