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
  version "0.5.1762-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1762-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "88bf3d1aa1813d9f55167eca548fca85dca553f5677e8ccd9f688eccaa2bc69b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1762-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5f4e4a8159c9ed0cc9d4da63f20d077cad83e130177ff034468b2f4de20b319e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1762-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1aff3039bb510acb02cdb98621357dee2b280d649ea91c7ff71bdea43e778173"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1762-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "251e055d83a0305ac9937acc5728b7413a5912e84ae0d0059791926e764917eb"
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
