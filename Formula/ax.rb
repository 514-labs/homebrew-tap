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
  version "0.5.1293-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1293-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "cce083932e2340cd162322e2d20ba8ae3d0218d0ef639ee28d77fd64c4573d2c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1293-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "671fb6125f2c6566e449f3186234872989482bbf4c773b0ce62cd0e743d594df"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1293-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dc79a509355198283983a8fd05097eb77c2a88d194d8d655c20262d3fc93cfbc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1293-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "78a75a58f3faff2f74988f69da626aec2d1717ca6d4d6dca9f6bda980270fbb7"
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
