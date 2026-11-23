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
  version "0.5.1785-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1785-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1c26c08b8600f09bdb5c06cf598e5f2c6ba39301f7e671e63c7991654a82c91e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1785-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "927d5daf353f6dd304b442d32e511edeef66eea8e7bc72b0aa4bdf980ea8fe1c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1785-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "80b1e7461e1b63bdc2fd36d3228c5284ff52d32cce4031f861c938e388659770"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1785-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "993cc00c88531ccd79ed3768c75a7909a339787c29e867e77f0786088b4064e3"
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
