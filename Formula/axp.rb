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
  version "0.5.1724-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1724-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a7a5dcb6b986c7ac01a23370bfad01d43b3430a0e97ba41606107144905c266e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1724-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "16ffdc2547eab5a2b5938e7960d92938c686b885cc369cc1979a0bf9f715efdd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1724-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dbff66c2c73ea4fd41a293021ddd91c738bb7968fe0e1fdf5968b7d0987f6c58"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1724-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7797fbf55f6d6db974e5339f09e3a58f629dc271af86c6580dfa6ac0ac66fa98"
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
