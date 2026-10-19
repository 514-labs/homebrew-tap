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
  version "0.5.1420-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1420-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a7b5a48871b6e608e1e3e297a83195795efef8fe75a3b7f3f544f0f5d8cb9cf5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1420-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8bf591ca7df7a6e138a6c24772051d513427139010dbf9c25e97f3523a21a590"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1420-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b1a6f0dbad917f4fafab366b685cbf6420f8e23bde81a9dcc02b1009ad896cef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1420-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4b3cb82a84457fe1e8d64afca45f2d454e87f2c1e65dfe935d260f36dcd2f27c"
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
