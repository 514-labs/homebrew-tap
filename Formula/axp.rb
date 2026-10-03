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
  version "0.5.1244-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1244-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "fc71f8c3bc5f0a9785e2bcda75d6a3b8ad9b8b5b907c2ec2cf151a15c4a0297c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1244-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "d00235efbbc175149360616b41164b8316d4a8ff68053f6ea4043a31ebd063fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1244-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "74e11f019b836e9f069ac5c2b1608af1b298ea10eed29b548c362a05748cc6bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1244-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "4fcfb7c4ba338ec27359ecd554218705991e07014083e1c2515856975d0d25be"
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
