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
  version "0.5.1714-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1714-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "48814e238fb5dff3024e5411a1af7580673d67b96dfa2225d4b84f486fb3f112"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1714-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6583061e253e9374abd4832c20f506eeb4a4283618d60e26b3c277f82d9565f5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1714-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "76843ed9947e54fbb6ba14bf62da289ec278ff34acd93b178786ce140abfea54"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1714-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "87e2fa35ff0eefc83f38021ed94db49fbb3f34dc0156fb4c91d6a9471924852b"
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
