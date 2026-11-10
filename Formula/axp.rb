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
  version "0.5.1707-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1707-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5e0f219718009420d2ec79dfe5ddaca3d0d1ce80b1c6f68544d95d2c784e3ca5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1707-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "036d0eabdeaaee3892a5d65a2507c0bc25e907448668b76561b644f9ea15ade0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1707-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f3b1459b68682e3934596bf19d207c3833ba9d602e6e8796eade2f8ec55d7fe0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1707-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "bfdce907ac931bbd66f11fca42ee7bae2cc11ef69870c82c52a09d2e4a85744d"
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
