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
  version "0.5.1746-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1746-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ab4369a7b6ad7c6d39c42821a1c8cd169755f030d019d30dbd2c603fa7cdde3f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1746-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f1986e8464305fa8a111b413d050223239607e0fef714ddbecf4dfbf3ca7c587"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1746-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "af509efcbe470235f6c21705225672f025054984947a7727c427653de14f1fb7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1746-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "02b4550bbd4989bae5dab732c58839f51af5be69c789fd4ecee614f284dace81"
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
