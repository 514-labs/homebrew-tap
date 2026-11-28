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
  version "0.5.1804-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1804-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "01f83975bb60adc64c9a9f94e828e468188ba7d7bad5c98a37cb8fa00e2e78c8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1804-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "22b26694c70a189419517a6cdb4c385d51fecb431eb31adea4bac2cf0eab836b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1804-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2fb71f1e7aae22fa48d7e357ce743b2c7de0b1615462449b50a62fb48a8926a0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1804-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a3b2f9788b03493385c736d48c8ed9e9613a05d00447bbf881c94e77b6738ea3"
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
