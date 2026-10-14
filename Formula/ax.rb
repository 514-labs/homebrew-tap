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
  version "0.5.1347-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1347-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c88821d9dc889a617c184b91a0849c4893a35cb0dccf2a6b1c8c47228c4b4cb9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1347-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e540668b3bbcd9c3047f28a208321aa1cb3acddc73f249f96fbe628577ce0ed6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1347-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bcd5db12dc4f2bca7151bc7d69e44e8a52649e6c9476dda5605e3f6c030bacdb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1347-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b2779094b487a387cc0241687e8d7f0d20052287e64f79c563c07e3f19391bf9"
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
