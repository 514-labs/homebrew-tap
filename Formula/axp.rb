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
  version "0.5.1501-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1501-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "cbb9bf19892261da92ff9f4d059b87c1435b2b6b13af195ef0b8ac61beb23211"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1501-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ed7f89a80ce53fac88ca2a955e237ccca320042dd7b165e5fb67f32c4f9ad8c5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1501-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7c689a0ce81e5689be4030e18e7e36a88439fe0460f538baffee3c13f815982d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1501-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2b9a6881a4560aebf2f8e7049ca8f3a744c4aba5ee1076323e7866c3b940cfe5"
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
