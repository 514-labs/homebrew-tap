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
  version "0.5.1783-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1783-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "461af253e364f7b835aea65a01f125cf46cc6ee4aa167295151c0bbfd2147c1f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1783-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b72c1800baa37ed35fd863cd14363f62d4b5b6db60d43eadba442ebf730a914c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1783-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "16f52e17aded4d0b97c0da69d3c6a542848e7b5167f37ec39f216efa6676aa3d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1783-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "de230f7715e1378fa199177a0e36389e276d650e2a4453a17b7520700235b98e"
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
