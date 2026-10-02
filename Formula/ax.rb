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
  version "0.5.1232-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1232-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6bca6b5cd839b2fca538b53a0558109c7fb8589cab8b0de30114e20255d0fdf2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1232-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9bbc8d834dcabb4326b4cfb18844bf3c89b07cc37cb3dfc3ad3d8f8f8ba9f055"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1232-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5f4d611bb827df02ccce0a318f8d17294d9b26a231f214d8b82ed83105cd3b2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1232-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ed947cb03b39c4a28d26ea3958b9975d6c28df9b5bf0207ba5b68b5d9edc221d"
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
