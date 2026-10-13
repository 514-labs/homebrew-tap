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
  version "0.5.1334-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1334-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b637e7a7e44041827114026a59cb3856a8006b194bcd27ac43ec3a5919d2f6e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1334-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fc26333b5be91985b1edcebc5445d2660e7e49093fa2fc66444bef8ee6ca3bb0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1334-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "776dc009fd78167ae393b7a0c3dc7ab961ef6b50edb30f171997876452f63a51"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1334-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "104b93d1abe933b4297ed2fd481cbc3edbaaf3a32bef592d5b976ff211e15c39"
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
