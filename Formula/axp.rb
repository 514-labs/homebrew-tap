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
  version "0.5.1358-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1358-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "0410a2daadea13c0422aa6120dae251b33c07bed4a39bbfd9af8b50c105346ff"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1358-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "5ac7b7eafdc7bbe8bb9e1f9235b68f2bdf6820f48a4fd0126a4c57ddd94f51ca"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1358-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "e2e956f51e2f3ee92a6bba1009c30411310942bbf81f0723a83c6429549e42dc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1358-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "81acca325c45df20e21b57dce04c2c30d6b64ed24b871290a9d6b7777b8b3b01"
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
