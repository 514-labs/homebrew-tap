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
  version "0.5.1444-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1444-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "87a9c1c2706f34d2f7d46d9e1fb519c5e21cbcae7816667ccc72a091398db312"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1444-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5d0db4f3218cd6fe90cf290437ebd5800a4360ea21e962013a375f2babb71780"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1444-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "48fa107590d2d8c7d002b466330e43b4e4d164906f2b80118deee41b8739a93b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1444-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a726d6d9c12e18ea7aa6c8f039c145b651f7dc690f602f3a7fd617736c05e349"
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
