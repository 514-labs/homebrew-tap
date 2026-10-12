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
  version "0.5.1327-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1327-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "88ab8d940599889f22aa452cb3d95e65149607779aec52f4034f1807bbb9c2e0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1327-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "092de7691cde9234ead5986babec1d56a68e83d4f6246983cca5a6b1a699b8d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1327-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "70e8110a0ea1d71a7f0d7177ae007673d757a490b7df8747374a1f2bb4cc2d1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1327-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "15381d6d2c82a599ce0681344736b70a45d44e5f1c3a997b6b9b70ca90e91c81"
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
