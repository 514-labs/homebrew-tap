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
  version "0.5.1250-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1250-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e8ba8e3a752a4c84143cb15136a594f6f8f5a489eb230b983841fe7227bc4d16"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1250-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "24dc952119003f373b459dc895de86543e555df1653b1b008f5388abda5b8f7f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1250-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a8289dc1a8a8a28ad28d2965f8ab32b8200edd86c484cdbb84aa179d4cf0c2c3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1250-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5a32d3d4bf07286b029bf91740da7c19ee8bbf08d021fe8d3bfb420b80f26c29"
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
