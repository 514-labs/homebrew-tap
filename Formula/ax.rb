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
  version "0.5.1538-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1538-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "08e29b9a157eb7c9126b9b7b7b7f50b567c1112398631ece3775995379607688"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1538-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a02a2751b0a7e3924c1adc475b312568a4f9a083850a8981a5aff654a2b2916e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1538-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "629a0848bbd9b965ea4da8c63941d2d18a88bea1275f4959e87f8d39560bb02e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1538-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "895241dcf994452109016692fc4e61f882efb425c5f761088c6d7aa897d8a082"
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
