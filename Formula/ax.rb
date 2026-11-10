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
  version "0.5.1712-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1712-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "eae07f57fa424b708d6be92ee8690f5af2a6f8e3ffe9b66b594ed14ce47eee7d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1712-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "06dd6e486783e071e4b04a25403d9d8795b51e7918db6acd3bc46c3218310bfd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1712-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c0fa0172560f49210d3dd9c53ca3e65fe06617fc4cc8fa669885f5e824d34a0f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1712-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6bd524004b4696f0d23041e37a08c71a38c7b0322fcf2134745542f6a3c7f596"
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
