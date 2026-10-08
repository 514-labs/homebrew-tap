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
  version "0.5.1280-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1280-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "c2723b55a8e2236654a39283e0a9f4ba403d825d83dc322c84081985560fea83"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1280-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "c6e2810991fe71f247f20843ea7b172152885dd05dc0fb21edb14b2c105277ab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1280-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "69b7a86a6fba09ca456b20f05a0b5e15f09486e8a93ef4b918b0a1e158237b26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1280-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "cd6f673ccb3ece042be821d3379c305eadf58bfbe1af2abb50dde00df27882c7"
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
