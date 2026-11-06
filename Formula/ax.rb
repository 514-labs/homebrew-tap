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
  version "0.5.1664-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1664-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "73468155081cb6107627e103e75aa5f24915f734cc146a2604c63a96202aae48"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1664-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3474e708c0856381dfb0bea8ef4dec53fe93999c0b1018ded0ff6cf46e32099f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1664-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f5a6e0e2c2e16eb385b2b4681ac338e78f2997467292852d180fc229d8bf4901"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1664-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e5b331ca93e2bd308de598c19ecc8ccf7e22591e58e3db5d016e421e9f6ba84b"
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
