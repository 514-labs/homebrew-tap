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
  version "0.5.1292-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1292-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e0b7a248a5fcc6fa21d498aead04d3a4f35a34dbba952f30ee2b998e09cab05b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1292-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5b62649f471e006a74c327d76ed1ce7a65f7fb5b51835521f32ad4315d181b37"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1292-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "057b094618e4f16a70f7ea949cb5155c79d563087e2de2d5c9d0703110c6d363"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1292-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "152e9d16574e2dc8fe1425e354e5152434f4aa8a4c530396443f42fa97f226ee"
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
