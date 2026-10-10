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
  version "0.5.1315-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1315-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7a9caf5df927c3a1f8f4c92b7293dbd7aab0dae90c4446964ef57195e42e0d29"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1315-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6c3357758d3aaaec78b6398dd41bd6f643e8fe78c04fe13a2b074a928e3a70f4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1315-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4e7c857533e5f325798ab4954b9a0b1bb5d8df99849905dc7aef632462f981bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1315-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4f72e8677ae280d950ecea4d1ca48cfb32f43226edc9236007c5a640cfed9a36"
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
