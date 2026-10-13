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
  version "0.5.1343-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1343-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "23c4d59291d5c8c5419db1c2fb7b019849c791a350392c3279578627339e3e3d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1343-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ec4abcd9790df4e1db0a4492fbaf0eb9d892b56bb2b52b95355f6a1c8b09785a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1343-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "130ece4420cb7f680c4c3df6e1efd113715ef4507717fbc9ddebbfd54aa99be7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1343-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ec94463812d8fdfb8bffeaab8e7cc24b9b6f9f6f4df7fddbcc71a03fd3821c2a"
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
