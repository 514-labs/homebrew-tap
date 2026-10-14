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
  version "0.5.1346-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1346-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ce70501ca7dfb69fee185bf60027380e496221f6a4ec35cc5e013707719fc540"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1346-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "05ca309b61e1ae82a4b7b3060943bb2edcd9d4ed842200efad13d0352034b20c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1346-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "da74901b4edee3544ade30eed8ffdcd2caed4f747c84cdf8918170a9b77561c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1346-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "37688831f09b8f0e9cdc5e6dd3a92c01e7777c9aea61b15ad25e20322f52cd16"
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
