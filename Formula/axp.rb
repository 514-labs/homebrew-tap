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
  version "0.5.1546-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1546-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "420140ec23d4cb2a97edac13e823b2f72e13f508f90600623596bd7762f9e4e8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1546-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "29991e3ebcb95de6810df00d40ddabdf99f75f0a0ba5362fe201e964c71748af"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1546-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ebc52ffa3a7b88cdfc7f1b7dd091ea1260ca11ced394f8fe220a8cc71b02c16b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1546-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b96fbc028761a9b3c8557887b3d1ce6bc163271d94e3bfb77bcbe54498db6b9c"
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
