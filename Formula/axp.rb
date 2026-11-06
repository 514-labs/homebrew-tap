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
  version "0.5.1672-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1672-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5a122ee930284e5e82e2692634b2b292ac0860693a803f5143465660dc90bb8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1672-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "33f4ff7a0b0d5931d9d21072e3d6cad4e4c89aa2595888b72a4a1b6fef3166f4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1672-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c10f19908beed7d29a6848e4eb5f482a80dc6cd6415af0301b91c28af6b5d243"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1672-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "331311a8b266772923f599de2c40fabf8bf6971dd0e7f8a2573462118087a28e"
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
