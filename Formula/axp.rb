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
  version "0.5.1474-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1474-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8c1af4240c7f75ad96a5e08276ab06615b733ba4a68439e85cd3da02b322ce49"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1474-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b9dc24076380d8ac42e087635bb16fb58e416eb8ac6c2021880b7a5f80be7871"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1474-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a6ab56c06ebd79b1825858681b0718554a107bcbe8bd0a1f4f905734d2546a86"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1474-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9c309fd0793e166db5baa05346247a117cac5afa82f50eafa7753469a6c577d7"
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
