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
  version "0.5.1299-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1299-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2cd3c61c64a3a2403d1e408af8da05b6f38f5aa349b6389c1899ab248826882b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1299-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "8eaab42b529d92a6b94f236a7407eddda4d3219edd4ae10089f764212d6864aa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1299-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "15ac1595fdd22075b065dcc25989711bfa2c1353be76798b9c97a43470a80c7e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1299-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1768dbf75826aea509b8497b7a6f0cf98b0033fbee6a103f5ca42ba90d855ac3"
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
