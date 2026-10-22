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
  version "0.5.1453-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1453-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "20c70a0650d6585695b7d975a0715e5a6ff49597028fdef0a97bbb5bbc70a743"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1453-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b357d34100f05382f695d9dee27ee6527bbbd812d593f3362bfc86840c2efc5f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1453-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "11bc5b0440565bf2a987fd366b42ef1d43b3cc500cb85ae7b18a3cb66df3e67e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1453-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bff9e8cb236c6cac99f0a712dd50d2683e74893d15900e499c56b31676cb9407"
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
