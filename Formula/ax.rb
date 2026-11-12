# typed: false
# frozen_string_literal: true

# AUTO-GENERATED — do not edit by hand.
#
# Regenerated on every stable `ax` CLI release by the `publish-homebrew`
# job in 514-labs/axp's .github/workflows/release-cli.yml, via
# tooling/scripts/render-homebrew-formula.mjs. Hand edits are overwritten on
# the next release; change the generator instead.
class Ax < Formula
  desc "CLI for the 514 agent-experience platform"
  homepage "https://514.ax"
  version "0.5.1731-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1731-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c873b761a698cfe97e35b3dc76928d8a1ed5c2c3ec458431fc501678f70c810d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1731-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a0878145da268053c112f4ca15083656407135253c49345d028101bde544bbaf"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1731-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4d6072ef7c2c2f80cfdb0fdf5f4776d6439f0ec884bbbf9d6422c61cc3368607"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1731-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "911523e0438b5ab91d6e4f7cf5819c650c7121b63ae4cbdc8a1be19615168539"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch archive
    # (`ax.tar.gz`), whose only member is the `ax` executable.
    bin.install "ax"
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
    # Keep the smoke test hermetic — `ax --version` otherwise pings the
    # update channel, which brew's test sandbox should not depend on.
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
