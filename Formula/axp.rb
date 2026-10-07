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
  version "0.5.1267-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1267-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "65792137f02f202413726c45c589304c729e24d68f94c7158e9d2738c590f488"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1267-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "2d097d91a28694e184236f648e49115e642d1d66a67b5377c641a1f68f82a383"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1267-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "f2b6c2f49daf912f47fa3c650057435b777555759199f285b2422f44ac4eb0d5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1267-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2254c7493eafc68f32db742f47b3cd9862ee4192b543b2cb3484987b8f3b92d2"
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
