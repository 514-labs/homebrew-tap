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
  version "0.5.1435-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1435-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9a70cb90e63783953a069fabdeb9999637eeeb4409745bce6401f6300fae290d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1435-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "26a1f13e54517794225a75978acf2b7d1f9bfeafc051524b8b6352e8fa3a5371"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1435-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e5c812303779bf316a575da644e19a8425d7191f07cba6543d2d806b6a30ec5d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1435-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0c569e2e850b45c709db7602eaca8cff54643f5818a4a44b209c3ed32daa9125"
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
