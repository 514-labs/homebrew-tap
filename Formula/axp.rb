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
  version "0.5.1431-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1431-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f7ade449735c05f6b5b8016ed52df61357ccb8394450c45e3a380b322e366c10"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1431-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e41d4c6bb0d29073b72376e8c77085039ebae8d4cb9aece11fda02d6b58bc348"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1431-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "183b0193aab8f45c5f19a46cb3b6132a8dc1c355f19788c45271aa4c1637c4d3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1431-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f70ebb01c0cbb3a04197473bab9d3c4bee6f9c69304418e7d2925cc604c0672f"
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
