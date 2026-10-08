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
  version "0.5.1281-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1281-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5e132c27743bb28806bf3b0f03265d9df45f8d741853f3ea94529e95f718cd77"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1281-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "381603e07e01a5384ff54167c7c4e03e02e3ec078265f9a106f4615c61eab43c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1281-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c8010eab9f394cce7ba3d85c411e916124828b4ed987a0cdf9360222039712e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1281-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5443ecd7ddb7f3f840f094dd41f8b9224385da1c7161e79d78a02669e5947610"
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
