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
  version "0.5.1473-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1473-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8d7f50cf0f33475e0257de77a474ef8b43b3b8adfffb21959208c8221b3cd5c4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1473-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5420d832e50303c1cc841df2c177e17f3f373256a88afdc3d79c5da3f71acf19"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1473-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "553378d774f8965bc062e408a46bfb08accc2dd5cd16422ccd24f5f12893d5b9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1473-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "eaaa372967168ea7c8e5706e25349f738fe28a3b129edd4ac97b016f299438d7"
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
