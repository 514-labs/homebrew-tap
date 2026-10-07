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
  version "0.5.1273-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1273-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "672f845dcc8ae139403c688c64d31b0c8a1e562323083bcdd203f82f0d9909b8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1273-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6e7a0e22f8ae27c977ca35bf2cceedd0ac84ed0c61e6146d2ed915f7a50d9efe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1273-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "308e1974a59eac583a918e19e7ee02391966942c4d4d08feceb83be3b1fc764e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1273-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dcdff159e95086c680e764e93772437e3c3455d50b2f2524ff1702dcec9ead01"
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
