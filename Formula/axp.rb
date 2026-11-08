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
  version "0.5.1686-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1686-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9ba3917b1545d2b247b5318561b8896e1cf98c86ef7ad97143e3885b2f3394b1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1686-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0db597b83c09bc678ee75597564f677321c96589bb428e3c07d3c622135d0ca7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1686-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "520071718ef00007293dcbfa0fb87031c6294d8ce934b47b6a2c974fc2a41f13"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1686-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "241d84408c8ffdf522884f8943d9c84c3b5188459475e074fdfef2ffb52de314"
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
