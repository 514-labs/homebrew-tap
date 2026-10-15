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
  version "0.5.1354-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1354-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "dfe95767520fec323f050b26bac388f6edae90652c5a41a2033bf6637996d5b2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1354-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "71e16c699aabd61d60a31f9421dc3a698c0b61be0d14d0545feccbe9ee2b23fc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1354-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "51a68cad81354ce2422bb7baaa23e674fa2a2ea91149050633956fcd54c02d7a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1354-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dd0a4a744c3d58568b73c54d876059b13a7281308e4aa282a313fab1e82b4c86"
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
