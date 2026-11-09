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
  version "0.5.1700-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1700-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5208a81c320d8ae7043d9d7b733c605f4a6c4546e069bead8c2d5746e5bc4bb4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1700-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "34d13743ff1a78c5c624187d8f7525b4111b41a64d22c06b884e59392cb370e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1700-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f0a1a922a27d03d2b1f3f709f7022ee04eb84245b24d095d89d8b6104d38c573"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1700-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "84f7759c041f2eab79d1d906474d6644b74379c43092012951b902850139d124"
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
