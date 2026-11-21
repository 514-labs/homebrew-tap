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
  version "0.5.1773-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1773-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "357b4798c667882e62138d30e3cb628f44ed1e7baaa7636a59120c3d1578aa53"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1773-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "266f8a6204047d425968b3adf9dcb4fd5358705faa85d0d4a1d93c70d03760cb"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1773-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "faedd25576a22974f637a3f7f94f7e0e3a37eeab449476e4ab6e1117dfd740b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1773-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "860b5f53e940e79c9946d76b9ae5e93b0e8ba6520fd11be7f8ab3197de717745"
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
