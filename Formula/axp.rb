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
  version "0.5.1292-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1292-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "90aacdde4bfd3c0fb58be299c067925128e3dbc46be8d26b9cdc4dcb8dc57c96"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1292-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "90a59747f703bfdfb3022a2cc5cda9d879b016252f3d18933905bea3a6fc6de4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1292-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ac54ff92d10d4a83630bf3de7094387854cd83e75cc7bc588815126151df17fa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1292-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b6b27247b7ddc4b53cf1f789462fac900812076320bec4725634a928d46fba9e"
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
