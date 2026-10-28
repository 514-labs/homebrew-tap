# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `axp` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
#
# ENG-3612 deprecation window: `axp` is the old name for the `ax` CLI. This
# installs a byte-identical binary that prints a deprecation warning on every
# invocation; switch to `brew install 514-labs/tap/ax`.
class Axp < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1511-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1511-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "275ac2c6c80752b660dd4f587c89f204aedd1715014d77ce1ef02a0b2aff1340"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1511-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9ff9c018c805dafe2df1e0fa54b2cacb3fbab4bec7e8396b674fd49fbd238007"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1511-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b40ec6ea21d3272f1cbbde29265f89c4b1001a009cf95dbdfe1959b98a87676b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1511-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b0e31bca5ac3f91848b407701c545e7dff919e1a9633ac515936d9ba583f7bbc"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`axp.tar.gz`), whose only member is the `axp` executable.
    bin.install "axp"
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
    # Keep the smoke test hermetic — `axp --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/axp --version")
  end
end
