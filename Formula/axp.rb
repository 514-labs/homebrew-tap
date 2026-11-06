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
  version "0.5.1664-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1664-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "73364878b6b62e0bb24a98e95a0fd228be0e5af1c3f4ebe9fa4ea2599a80ba2e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1664-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7ebb816c6f8187ad17068a1420eac3bc9cea773d0d0d2d970f8c581143b5f203"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1664-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d20158e8d39cdff3ceb354a7b429452fde733a11efe69382b3dcedd3cfd5577f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1664-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "070b3b60dc9524f14eadb50286a62ec7727d0688d1d1e6159fae6c7a9622a46f"
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
