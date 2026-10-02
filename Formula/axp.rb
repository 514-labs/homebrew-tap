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
  version "0.5.1236-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1236-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ab0907ef7b4af95799684417e20d74ca9e1d3b9211d29f79b9199482e22dc5a9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1236-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "54a7f33b5f7099414da3ebe936c85093b68c8f900beabfb027cc49d23e248776"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1236-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cdd254e29b2626243ba63018e31614915eed6558d4fbcbd68241d49242314ddb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1236-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "60e32a04debfeb16719b6d1f864e2e34b5b3efa783e60727fd3906f3bf75ab9b"
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
