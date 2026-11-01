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
  version "0.5.1624-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1624-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9906015a013fb2f671a7ac315c09bd8cfc7768bee235e1ff9266972335563d4d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1624-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "606be326167119a0c0d7f72c9a12bcbf07ac1fed639ce2d07faeb91d2dbbc205"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1624-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1445f665079e57065f13db65bf724e73cdc24394ff1d99c303151fe175e4bfb8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1624-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "92c56d7b9d697ea4c48d8ffb41d09c6981aa3d8c822eb5ab480e050f6b8c7bad"
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
