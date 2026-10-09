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
  version "0.5.1311-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1311-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ca3433cd401afdf35f4befebd2c89b217a1a7d07b55e0e52a73c3399b028a332"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1311-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "ab29ea14c4f4c2731f974620cf809b597935785cfff112aa2bf614d48c42532f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1311-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6018dbaa0a179c9349640120ce067081779ffdbb12a8ec74b0cfb1a46e206a2e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1311-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "637b0548a404b5a1692290298baed56d36fda2caa842e68f03c33bbbcf354682"
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
