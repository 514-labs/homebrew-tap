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
  version "0.5.1265-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1265-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d663630edbbfac8774e284a0eebdd8a593d8b148735d67add60c6e077f7a23f9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1265-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ad3ceff716063c813b256653788e8ca34468da47546069ac94fe260fc658f772"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1265-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a907bdaae2b93c4d6a6cf77ea6fe686b3b2bfad7208f231e4f3a0eeb8b3cba2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1265-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "310a6d8be5860bbbfa46fd214cfb9f8bb054e160b74a30af685dceb9a5dde4e0"
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
