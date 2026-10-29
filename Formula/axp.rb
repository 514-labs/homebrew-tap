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
  version "0.5.1543-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1543-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1298e72ac258a16e5e7b5ef9eb25da7a93698298c51f51879e0c817cf6e8eccc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1543-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "10f2dbec4712d85c3a331ea4d037b60eaa98aa74f593ac85be811f3d7b7e493a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1543-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "81bfb5e3eed738b2c23993c2a15a45c79915765e9521615df36ad193d1e3715d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1543-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "586a7102ea6e7f766c14d7bf837a134dfe0d8b2f53c2a04179ecb190d6697b54"
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
