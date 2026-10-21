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
  version "0.5.1439-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1439-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2b1c06274fdc0a7542f519222269787fc516dea7e783c4898d8ee15454162202"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1439-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b6e40a934ffd719c1531247d76bbd4a6d322432f77dbd8f16e42f1406c6bf0fd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1439-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "129b6e9b5bc368c7f0c5a7ba2694aafe4fb13722e5f469d5fdfdebec966a8688"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1439-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f5461de9fe860214260df75f7e9eac8b777500d7c0143269605bde8ce60763d9"
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
