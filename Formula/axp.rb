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
  version "0.5.1282-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1282-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c59977e56f309c7065b260837a32c324d9eefa19b44f4e787059271ba5580b19"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1282-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "77a1ef2a7e08cf9aa14e1da31ac43bc706fa12318cd83b874ce526cf624af7e8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1282-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "313e2b48c80585e85433147100604685a6775c9e5cefce581892edc03be9e49b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1282-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "9a96f2a5e1ca89815a45c8a558cc9799fd1d50a878bc6dfbee4081e12f4665d9"
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
