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
  version "0.5.1663-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1663-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "6dc0cbb2774dc01e8b1b4f7fd87950c4ff1389648f7efb007a22c0d693ef0482"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1663-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b1e863a03c89e771c31fbdbb543943a0852ab02bd04cbbcb8ba760cc093b1964"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1663-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c0facb493cfa25cb13ed878533cfdc21c6770bb9145d9b855fec2f3460ebd1d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1663-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "00ec44ca373751398a4aa5c46054f22ad050f4eab3e9b6d5d08a5214bf3f8596"
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
