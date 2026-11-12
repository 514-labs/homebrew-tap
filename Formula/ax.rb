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
  version "0.5.1728-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1728-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "373876fe3f138c82f2c22518a317ed2b46b01871f768de27093564f6a881cb48"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1728-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "690ea6ab36285996467804f776f780b70cb0cf361d28a2e6b1c75f223af6d437"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1728-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5a78c71e58fbcc901725bff898a39afa613f85e1c4e2a161da4d05d47f95572b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1728-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5fbb961f6f37053542e1f5816bf2d46291df747f35c05b1ce61eda807a1948dd"
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
