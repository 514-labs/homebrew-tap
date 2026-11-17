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
  version "0.5.1738-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1738-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fc18f6976b3863a161d5a0028b81e63e687f79a53e1b714972ee64da95ad2fc9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1738-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c299c19957aee488f36d59842aed9d6b4de1034613ba7c8a0ba8209529def6d3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1738-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2daf1a205921935c38a8afe8790509fb1b4554b2fe3caac25a6501456cb877ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1738-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a6dd66a5d78bc5d799b71b67d9b0e951feb3912596277b38b4954ab84cd4c4a0"
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
