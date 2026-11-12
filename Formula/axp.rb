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
  version "0.5.1725-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1725-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "2451c9903d8a86c5850dbd6714150e0c7907b92b3bb3d491028091874623e8da"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1725-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "7d7390ebbb4eacad15ef9a3568d744a13d5879bd50c05e65ae5e6eacdb2464e1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1725-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "d47f94003dcd598b2bbc6f5b2cd87ceccdda97095fbec914684a0fcaea051839"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1725-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "04dfafd8fa22f0dbf44b86fb985b1a21c6c90303c31ececae3840cb182713de1"
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
