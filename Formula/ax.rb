# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1500-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1500-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "530b652c02869d3c1a114fb24bc212cefd9f68789a24a7ac7de1b7cdbee03d38"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1500-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "df11acd851bf7c022ac94a076c92993d363ce3c4eb02bba25e76da12277fec4f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1500-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d13fae15ebaf05bc176448b1c33b6c3709ce0b5fe4f6e28f6d5ec227b2d3dfdd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1500-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "150c40f5d23512c5b4146e2583701bec0ac904c2113ebb564afea48c175b9dc7"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
