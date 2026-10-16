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
  version "0.5.1376-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1376-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e3621306257071159828521cfd3a5244f957ba54f80d86da4682e8a10b7be709"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1376-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e2186c13b6c85132ba50ea5db9d3bb17700b7cce42255c752cf920f9f08b5d23"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1376-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "343fef15ca5e795920ef7cf099aab263027a10c39ab506b0ca1da98ecf438aa7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1376-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e5f748284d85aaf2496157e24ceee97b0cd4ef3e045902f0ea212cf7ce5a5014"
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
