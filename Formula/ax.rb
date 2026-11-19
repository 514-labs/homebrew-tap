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
  version "0.5.1760-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1760-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "af3587f7fab04a372330d069cccaadd5f192ac33f79dc2ae59f9a56becf41c51"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1760-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "550f7e20618ede7b5bca0fd20144fc43a1dd2083038be7bab309e6541bcf7f63"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1760-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b9391c8b80a2197d49493488f7a21d534d4e8420ac81e46c5118068e037dcda8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1760-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5c42cafe85219aa14be614248c007c487d376f09afbac1a4ade4c953d019517d"
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
