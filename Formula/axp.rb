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
  version "0.5.1703-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1703-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2174fbf88ccfdef9a18a7b04f03d1bff13bf584ceea6ed63f76fab993b2904fc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1703-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "a7baaf65a876356164a22e0d6d0ff14dcd0bb26f06604f6fb21f4d3a5916339f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1703-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dee5228b14275616a372c7a85ae5745d6960dfb4480c45ab3511eb85d0d0fbfc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1703-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0880d254dc381900c91490bbbc096463655c62b61d2c9a376bcd15962e8e57c0"
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
