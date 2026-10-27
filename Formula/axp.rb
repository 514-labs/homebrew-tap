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
  version "0.5.1505-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1505-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "a0b02e3b4c052254499175381ae8e39423594be74d9140574b0a9d4b88ca1e63"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1505-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "773dfb21ca556eee6197bc984a8e87ecaf7ea9979514b7b319cdbb9fdfd491fe"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1505-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a56993b1be2dc3465a7b0a4d92d83f81d3eda6e803c0f35ea78ff17804033d6e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1505-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "6c0f44ef47fa398fd01428c09b50b680ff37dc7bea7caee5a3298b81a4eac420"
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
