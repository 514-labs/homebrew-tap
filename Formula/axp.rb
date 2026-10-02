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
  version "0.5.1226-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1226-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c944f7c96b98a1a268c8fd290ae4aea7def6ca670fc9b63706443eb374b28fbf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1226-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7b7586b7ef5ee8d70b07aa863a404ed171033553c3bb3a4bcf0fa35b3336f596"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1226-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "71bea69d52166b44f8531f76cb0a210e65ef093405b3232c90e8930c94c36db8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1226-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c063c418f160a7f22c711465743509a90e6e356fc5eb042be07206e7d23044eb"
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
