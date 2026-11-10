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
  version "0.5.1709-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1709-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8a16f31a6c53c7ea1b65d2f5eb5837d2f5b5a31761369c60a34ab53265b4738d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1709-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2f1fa811cc9da25d4ce0e6186f70660cc39cabf1513dcff8aaf7d967b7f7f4be"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1709-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8988bf9bf3937abccc727a06e4ca38c15b6dbc61c787ce69a4cc7dbcfd83313d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1709-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d287a3a6100cabbc8ca98e0081ae17741eb76a4e4d486215c70e0177df5c3afe"
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
