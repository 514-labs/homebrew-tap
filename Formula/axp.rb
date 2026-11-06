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
  version "0.5.1660-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1660-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "76b3f985dca856bfae707edc00af091b0446c0402c0e717d9c7f9dbea71f0120"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1660-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dfa932f97443554f9bfdbbcfc5b4e2bf5e1137f31e7873d819bd828ee89d66d8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1660-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ad426806985e56adbd35d5e610f66e6d6b375099b319500327207b62ff58272b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1660-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "df09a8ed11a5c49957d5556ba3a2382968092f30c6b8da3043bdc3f4a790e9c1"
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
