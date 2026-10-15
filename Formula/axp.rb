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
  version "0.5.1352-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1352-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "d35fda08c99be57f320bee6c7744e6551f859e9d21fb39bf5fbcbed5f119e6ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1352-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c77716addb21d8ed6d0d5afc750132d10a29978a52fb19096b613267e68d9646"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1352-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "b6dbe65a21c200a9cc4322b0ed6a1cd7e3d4d4dbfc3f26ff967f1b96d2d28567"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1352-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "48081341b6009cbd16b6c7c7497c78fb47b2cfa93fbd43df6eb2c1b96e0d825d"
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
