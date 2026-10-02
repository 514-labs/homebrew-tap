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
  version "0.5.1235-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1235-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "63f0152ddb2c47c1a1da28b39b540e473bcb82c621a6f457328b49ec095cad61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1235-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7d56f828145062ac99480906ad8d7d163c029e88964365c70b609766089082c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1235-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "24586168f3d30e98c39b5823b0592a1bfb4fa640a9f30478072e0769fbc84f9b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1235-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8c526e1677a6c49796407f98db01b01b4730e9e61a33173fac2be54425eb412f"
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
