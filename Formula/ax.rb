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
  version "0.5.1735-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1735-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a79005f35835d9010467ef2771c84082c4571addb94c258c142ae0c3beca95d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1735-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1ab884d1b4acd70619ee91bcc02248a0d1d66d05c50fe89e3a83302afcf15479"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1735-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3e2b4c55a82f0d5b71fc94027a97820be2dbeb4143c5983f68892d2b962935a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1735-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "159ef5b5d1e1ab59080d5a1ce822ebba3caa817e4d3a439203f0665677a306d0"
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
