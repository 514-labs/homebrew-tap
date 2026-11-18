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
  version "0.5.1758-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1758-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "5b2fc0363a6b8ba730bb1afe63571071e3c48730d86c2af8e7034390f8e58358"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1758-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "1549e33d8650b39b6e041428f6dbd598e3cc43112912efd39ece26595a7b491e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1758-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "aa5d2e4d039a796ee1ea54f0fdf6bc6f14e1cc2d1cac4cbdfbd54fc7214fca2b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1758-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "3395be3ffcf0d94025ceb80490a558d10fdbe42108507404e8e25019ac1578c1"
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
