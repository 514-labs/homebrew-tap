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
  version "0.5.1373-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1373-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "549159a3797f8c3fa446a610c891e91e528a38f5946c20c81b3da3dfed39863e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1373-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c39f5149d38f7832919da9912c158f0b3e5545cd14b8f470ddaf572ac7aa90fa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1373-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "194e7f415829a5066a3e1d968f9822735d8b71c7535e3a0056055465d4f23e5c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1373-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "243f1b8b04a1c177181a8420d1d744e308186c11ee59a4258fe4ea5a2c55eb44"
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
