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
  version "0.5.1640-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1640-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b2910799c4eb5c6b5912220bf131f7012601e1b0eb97fe46c5512f698d8fde91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1640-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "306e4ae9a3cf0504e26dcca41d3d19dfbcba6b3b98a31025f9b2635dd31d4145"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1640-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5d467b80e728347fcee6767f233f429b7268edacff8d0bc5452f76a5302ea765"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1640-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "74c762243a60103e759a53427b4580e15ca0e65366dee640f044f0b67b728d96"
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
