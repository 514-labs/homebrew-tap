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
  version "0.5.1766-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1766-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "1136bb854acce4624e997f706baa95aa644a815ac01c1d5548ae2c76e60d72d8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1766-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c4ae8a2266b9d3928435331a6b1e5b0ccbb47d83a0869d98f63b727069b5a620"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1766-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f53e4c809fb0173d8eab3f9bd6ba3755e1a0e235ff7228f8ebddfdc05113e012"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1766-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "7102f8c9bfcfec9253c6f342c67ff53d0977c5d22fc8484fb3024ceec5a2907e"
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
