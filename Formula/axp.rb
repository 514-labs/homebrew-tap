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
  version "0.5.1775-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1775-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "8d7a45116853a29e06b1239c538ca9fd6b07c61c544c0efb8a099ce7542f5587"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1775-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "b40219f1a663e999d811b5d30c3c1139403514e8b1ddd7cbe1d6009591dfb477"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1775-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "baa1e0e3ebbe1ad32f910a2e45eb4bcd13ab4267a2f4c95883316dc5c5340884"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1775-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "8bd03b1f67968b60104786ac5684de179e9d567a503a87b010033ab77541be77"
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
