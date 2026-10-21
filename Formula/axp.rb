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
  version "0.5.1437-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1437-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f3df8d0063b5cc44a9baec25a2dd45368883450f7dc7e9dde9789f8bd5f50651"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1437-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a29253033a3ad2c58e67a4b625655cf4d55f0f84d459eba9cbcdd8aa47554e5f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1437-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "54325886654214a2c8d12e112759b9e5ccfe64f44682bf1593d3cda8de391eea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1437-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2447e73891cc3ea877649da990ab2a2fbf24f293c3fa5ee693a08dfdbaaeacdf"
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
