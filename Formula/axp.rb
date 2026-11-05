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
  version "0.5.1644-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1644-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "440e89c380b4244c2f3610498175c688991bad7f9353387ed8c74c444fcfe8ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1644-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b76fdfe32c456785225b6502bbedf4b7c29ae377ed5481c8cd485f0970f3ea1a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1644-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "123ae5d6bacf9113115788f7c01d3e776e9c4134c2fcd9ff4038ff46306c681d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1644-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7686f3755e14b50ca631b772d116a1db21e36edcfbc199b7f2f4e13672e81870"
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
