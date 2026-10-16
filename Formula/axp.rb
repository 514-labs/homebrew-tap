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
  version "0.5.1391-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1391-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "3c7614fb4927f608e3bcf5cbb7cedfe7e6435a232f5f530b4eb5fa17f4d3334a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1391-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "79a19464b828379c9d4c2c19abc5679bd2369da22b0f0c1a6b5edfc076b3e1f0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1391-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0bbc1c48c9f71de9526c45cc295967939730574e12fcd7a7937ee693b8d8a72e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1391-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "277523136c76b2f429ecce08d9e7e9ef5dd38556d2fc5dfaf88e2146f4552f66"
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
