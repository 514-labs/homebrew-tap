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
  version "0.5.1446-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1446-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5bfee66f351a9a4e9fa3c0820c861a800c332b14f0ea41440e7e19a0d30b3a0e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1446-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "468fe8c88ad22e19602bd2f6daa32e961ed4b0d24e82696ec3033866f091612c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1446-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4a2a76b7eaea605b6525d34a5cfece89ce95e0386306dcb5d306477bdb95472d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1446-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4d01af7bab16d554b01eebcd68a3057e0f9c57ec96355220b66764aa22cd0ec5"
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
