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
  version "0.5.1265-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1265-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "079c0d8585c7685aaee812c6781374874bc52c5492fc6b57971bcf30c997ee74"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1265-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "150b8344857e312e70deb8de93f1095092dec46a7fb323733479f42afa384344"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1265-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7cc3078043771587f497910ce2d389d6d88a8ea3185b27f6977c6bc3668c0814"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1265-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "13db2ed1fb9c3f3cc367d77fd1abba1279587ca181872441eee2b097b1c01c14"
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
