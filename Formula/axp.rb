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
  version "0.5.1487-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1487-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0a561c2093557db7aacab3c05fc413853e31e14d6f53c60743cdf7e3330be20c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1487-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "dd36e10f4a45911165c48350cd38c1810b576483871266c0ef0ed217f6914c30"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1487-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cfdec9bf9f0a383559afa8010dd846a92ea553528ef9d12cb7a9fbcd9a4a09f8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1487-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7d67707febb347dac6d683a71a9eb6e043f3bcdc01a3c626a5cc90a136f401e1"
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
