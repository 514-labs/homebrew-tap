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
  version "0.5.1699-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1699-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c7dbe8566ce6bee74dfa65186053240fb280ef47558995d63b3214c3ee50a1bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1699-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c5167a8dcda13d9874d4bf43ef59507d84a87d00e071cd8b2a7bdf7c7ea6edcb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1699-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3fcb24da29f378db34a385fe3ff17e21a4c6a2a6d84ebd6b4c9e80861b1fe51b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1699-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f7cf48db186a746f753afc5b4de3099b84f7f80e6d9017e3be950d88d4e79385"
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
