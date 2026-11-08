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
  version "0.5.1687-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1687-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "573a8d0e88dc41b89d26cb6cdcdc2c2fa5f5624957642d1dfb9e67bfdba0dcf9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1687-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "81b2197d690663176cbe7be19ccd2bdbd14d1578f248204f24e903abe5ad7411"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1687-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "c7c3b002908488381581861fcca5cd559f74cd4696c5d43c4c84e4d84246e57b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1687-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a792ac937be81b78bd21faa63f7b487940118a0b80b44cd97403698b2b5c076d"
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
