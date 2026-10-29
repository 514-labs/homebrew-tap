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
  version "0.5.1535-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1535-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "7762c057ef9e0720fa1b14d7521c11075c9fda08e40daa9c8da3c475b624124a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1535-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "4b4e92a65aa8984db13adf3ddde434a2af8515e2ff47c5ce0f5de95f05a15123"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1535-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "1f938b959ab123d94608d996f87999460791d6960032704a302f0bdb3d606d22"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1535-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "dcb9797f1813467224ebe378894f58c64c6a942fcac8e505ef5f25d6154233d3"
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
