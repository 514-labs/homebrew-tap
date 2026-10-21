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
  version "0.5.1445-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1445-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9f0c37f3de1818788d432fa6056895b57ccefc2cf70be426a603799c8a90375d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1445-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "37d14276f9821f45b1bd6e9e0db136d1e3955d040414d3f908e5b5234c3c7525"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1445-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f097a76ad7056a2963ea3ed42c0b14b111c9bbabcfb6a499fa99e651339ae14f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1445-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "504f84aa5207e04f53a9c0bf34ae9dd3822bf7cc002e34b3cbca569993742429"
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
