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
  version "0.5.1646-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1646-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "278c2b62d525218a5e3d1caa0079cc23ee172ce5b08407afba285170b52e00f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1646-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "88934f7e3f77cd62b197b3675dea2dab56fb02d2c42bcb3e05d2cf1c3043e167"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1646-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "09d7c6614bf0a43fa5a7e25dd559d64fd34b35fda1d1756f75afe54d318d30f5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1646-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cfe4e0291ad1e154d026dd5f7fb18fd54425d4d42b9e9f96f5268ff2ca163d92"
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
