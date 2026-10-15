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
  version "0.5.1361-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1361-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6c72573f94216183cb17a4686c2fe689c241c772a6d1ee3c3d119e5f7b49e91b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1361-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "60f977efac425c53b22493122dc762dc5659b818b07239002e8e9a0eab1484c5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1361-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "746642482fdc3a4bd5498d83426201ebe28aa4cb665d23c4ce96b96bb8819212"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1361-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "10dad82915254d3dbf58a2a01b573c041d6138b65d9662d04f4b73c9458c2c62"
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
