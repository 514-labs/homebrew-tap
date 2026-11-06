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
  version "0.5.1653-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1653-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a6eec0335dcaf2c66378942e6870de5d619e34629146e7e548589a6e22c9d28b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1653-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5519b9a2d5810bd5d932833b01d55ccf3091e75b87385c337befe5f9f5dbe78b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1653-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a3cc361baee345cd78ff31e53da4300b7c8badcbc50cdb4b1e13a7f22fefe62b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1653-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c6960f0795b9c4a388b25aa68383e04c10275ece6c6f71edc08cae2bcbebc63d"
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
