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
  version "0.5.1518-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1518-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a09d271e7f26bfee712a04c05d775ea64f793389aa51f7e30d2429eca9039019"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1518-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "68fa39fe48a726e7e80a7c6ec024152a982b7629155d8cc5c22c59c04a4c69e5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1518-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ea4a7f095aae3d96423c0e1512a0397a4833030815f48f53be26f591289612d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1518-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "0f6bfa308b1e75a3876270cb9c9244493d1c36b60751ec95364ac17adf37385b"
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
