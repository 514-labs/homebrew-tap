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
  version "0.5.1744-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1744-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7b1836e3e1a8368d016715d54f63e9d287bce8e00c0c338415d71fec8ad2daa5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1744-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "0331fcca1daee74f8aa2f5ed154e165e59674ac05af99a947ec5535d8e0afe63"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1744-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f85de97f4e0da3787fb36abe5386b9f0aca1a5853ca7534ae1a948a235c39c58"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1744-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7edc6058ef7e153693e3f612df4a02a35c018fee07c362863e00f75a839887b7"
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
