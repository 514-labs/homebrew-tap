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
  version "0.5.1504-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1504-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ad4f9ad387e1c707a3f50ad6032dba42282d99c342aaab8c36d73f09e2bca7a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1504-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5e3a06b4cf69cd6d1141da06a59b1e4fe26d21c4bf38c34adb82c93d4735d6b1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1504-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "ad91356e6fe1de174250484797c9bf8bd8bd756d9952a25f6c8065917de6e6aa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1504-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1b73f01d924c8c7642a43e43d92f042452248d20e53b30098056bccd5d6e98e5"
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
