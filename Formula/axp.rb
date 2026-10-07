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
  version "0.5.1278-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1278-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "e2293be15deb315eb806bd84b3ba2e7b8fbe60960e756c4bb83b4f4206148ffc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1278-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "85cb9e04c5186b1453c677c0556cadcb7d5b86b3496a651b9b551347bbe1bc40"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1278-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f0d88aaaeb0501481f6eba963f702406ab90d8ee075b04165be3aa2eb5110c9d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1278-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "350b65c0c957cb5ef0173f6f58109add827ede09ee65568cce7d78aa48490b52"
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
