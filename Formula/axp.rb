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
  version "0.5.1238-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1238-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "b7212cda82d43db40c76239076aaad1cb12e5293ecb11e8611e284825b251e93"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1238-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "806ea8379ab73e46ca917216f853b119dc07b494ffea147d1aab19f05e692397"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1238-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5660b4406dd6b79b8a89c527505ce9086b3f3c45c45c5cd682f50a6cb6ffa8a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1238-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "747d873adc5cb85259a0cc9c269b9e6dd6ad0ddb24052ae0eafdef87fe9c7f2f"
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
