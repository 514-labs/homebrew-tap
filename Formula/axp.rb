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
  version "0.5.1717-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1717-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "34f67b162d1118e01d9103d977e42927ed71a9a7f3688d1394229624f414b378"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1717-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "9f441c174d0b38971504a1554c499fc4de822ae1dadf46b5e73da02964982a16"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1717-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "582ce2a275cca7bbb80bece16c53755f3ad444615a33de49ebc25ca276b87c3e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1717-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "21d09997e66add06e87cf2c11fc0d9f291d1415db186bc8ec51c1119a6383b09"
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
