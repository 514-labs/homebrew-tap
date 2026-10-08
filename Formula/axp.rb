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
  version "0.5.1288-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1288-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "faeaa08c73774db68b1fbecae61990a86a92251bc02bf3ad295f5307469cd83c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1288-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4540869fc8cf2166b6cbabc4ccb4b77c55fca052ef1e5c64726b35645d58550c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1288-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "18a5b1a8f24d38351e267a99a13ecd7703694cde33ab5af7d88ca68bb0c225f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1288-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3bc703794a18a3ff579bd5d0c9e07f804711a1debc230988d22385729395017e"
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
