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
  version "0.5.1509-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1509-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e71bab3f3791e9a5edd0671ccf2f8be8cf68dde715e257b177eca9aa30bd9d87"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1509-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "454e9499019214f7ce035aecb912983418d2b6fbce2667b4ac4a43bb0aedb367"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1509-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e36c0d8d4381ad4d9a79f5748dd697e2b390ec1f26fd1718c2f02d3f6207e989"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1509-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "53f6b33059a6637ec888ad05553b0c5fcc29a9f1cd855b13096945d33490293a"
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
