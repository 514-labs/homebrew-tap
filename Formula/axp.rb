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
  version "0.5.1430-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1430-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a0109cff994aeaffcc9b36e1210442a3323a4c58462a725e89dd844f592d5fff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1430-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "3dc0e853c2da9305d88ec45ec5b4ced2a24214fdad099c858831eabb74b48399"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1430-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c40aa4e6eaf26b9b9c91ac7c9038fe7c9c1b045bdd4e03d5c8ac4cbb1976e1cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1430-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "235bf6c97740ac1951fd6d5c4c2f6efac46314d7477c4998d713eea238467538"
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
