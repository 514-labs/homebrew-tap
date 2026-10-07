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
  version "0.5.1276-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1276-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "f989936f0fd172f0d66b8f1b754f1cbb28c1135725760ba3aae239def3d02f71"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1276-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "857a0276e0d9b13ac54a408fe776595b518f57c4c0610374eae6efbeaadfc28e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1276-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dc207cf3d7cb829a1bd0a7b6d414119cf9c9e2500ef97bb013abf3ad7e61835d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1276-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cd8c5392f30b7ab21a972a0d37de2ea929b999703400c6f26e9797108a53b182"
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
