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
  version "0.5.1759-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1759-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dc4cf1defc9fc001df82c14364e7dbbbdad1135d0eaacf3555e81201e52e4d9d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1759-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8c849a013f298e707ed39a12c66951e29342964d4a86bf58db4fd02489c4cf8d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1759-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f98c27cdbcef0963aa97da3d284d44c51e391b83422f8755d61271426be99017"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1759-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b4af2d04e97ee7a41abd693fece945a2cf052a26f07e5cfa34ba507db38bfe3f"
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
