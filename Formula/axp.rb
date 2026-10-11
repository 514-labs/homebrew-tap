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
  version "0.5.1319-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1319-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c2cc51327c3e8ade3e5c3380eb2dedda9a01062ef0712299f847fcb387eb3af6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1319-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b796e08b8bb51b362113f64f967e493c975abe2e74947174209535ab31bb01fe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1319-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5a19caf85314a17dd9c86739c3f5ee1b97999c271ca0efbbcfee99f7eb50e175"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1319-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3cd13dbabbb404bdef59276ee91dd99b3319ee35418953380b47ad7677bc9422"
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
