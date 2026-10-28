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
  version "0.5.1525-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1525-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d781e30ddceeeca92021e5676e56eb6a8ee8a9a08417dfad62517792830b73f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1525-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "868a6477a7223d43750101fa247eb0e88e78ca0821d4425ef39eb08b62ee413c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1525-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "13c66927546684644209bd7264985dac1a530c89330beacc1eccf95fc659ba1e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1525-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f8771a2d57903618abdb4fb12323ff87ae8d2be3b2faf4e5a185cdb59fd9b514"
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
