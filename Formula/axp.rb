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
  version "0.5.1484-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1484-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6ef00d508d2b58f7e15910ea454ec3564880f1b8189618358bbf957d5fd0b039"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1484-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "87ce7df517b2c51e82d0aa502c03d3dd95e8c3f5a0dd7ca2d8895de997a6cf49"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1484-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2a0ee522a03538f89e1f88c4024061d498bef41fe6b9a71bf9abb0bb21ef6289"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1484-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5e147e51ea0c1d345835556664ae9befa112c7c9e3204ffe6b4364e6f9823b73"
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
