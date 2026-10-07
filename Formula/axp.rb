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
  version "0.5.1263-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1263-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "ac6fc4de5a2dfba39f5bbca8acc8769eb2afb27123533893fb01f9bfa89c950d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1263-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "e072034e8051117b78f112e9b1a47a9991ea6afa68becd92544635a31a973ab2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1263-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "442991d48b87ed101f0912c13a2c621eecbf9ecb6dc20f222db74cef0050ef5e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1263-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6dd0dd688c1f129810679925ab4615d86296bc3280d7927ceadb721ae29c537c"
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
