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
  version "0.5.1726-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1726-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "88d874e5bb6dc2bfe2788ce45160a65ab166e600d1a6b3933d1401aeb1b25f05"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1726-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "643b17ae04b5ce77473af792c35575dd3eecb9bd20a5bdc4ad404bbf0dddc375"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1726-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1094ccb50d8f1711ae08255ece29761790aac59afc9b1a36d273f5bc49b38929"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1726-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "11495016e1d40d98ed662ef0f74fc9acad62efbc7ea4dc57db10ac851a4436d9"
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
