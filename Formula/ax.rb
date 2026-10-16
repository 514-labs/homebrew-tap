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
  version "0.5.1379-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1379-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5b9c8399a7f06f03cfe4fc33f62b424ed67ee19a37fc16ae4de44ffa70268e12"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1379-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ea0aca14cccccbac93c7aec738dcf31e3232d4c3c9a992b213a51fdf15b4796b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1379-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c93df425da65975460258fef667067aede023284a5c9e326631501be99654672"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1379-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f17da3c13be0f79bf8ee0b365b52421172e73881a27caf9523d0c3b8f4323310"
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
