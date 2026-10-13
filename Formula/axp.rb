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
  version "0.5.1337-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1337-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "9527bea338d2bd40548b26a7e829cd26ec26738d4a5a2d422722324a97363cdf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1337-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "6ec81d1859e07f64c36fa31a25fd2fac0965c7a5e87d502b84e3d64ea1ec77a1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1337-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "5330cc6b88a1b79806f5e5abae87405f226c3138f10bfafb3ff5f30f9be354ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1337-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6f0d357baccc545e89519bcdcd7f9ad16b3a947212c074d9bb15001bea479ce7"
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
