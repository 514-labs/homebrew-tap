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
  version "0.5.1318-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1318-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7de8bd5cf86c8ec7d8f6a05f4e80669722ab87411cb3745c1c0639bbd629cbe9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1318-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f0dfc7b871e36599f035d8e877d78f3cb3f3148c2c34372b5d2b73d9b2d4bbed"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1318-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d0cd34ca39fd55eabd32e335161737d3d2fc6da64fa4277cb819ee5c949cb5d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1318-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d420cf2914af201d7193aceaede2eb976b9c83239002ec227f9d966f9c240686"
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
