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
  version "0.5.1730-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1730-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "80c98655ad4c59201caec38483da5b4feb61a95a2ea74ea286bbcbfaa4b24488"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1730-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "f0087d87c6363338af0721c3b3710170b70b3bcc7acb0f181a67c23ab4c8fd18"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1730-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "188cd5c635d75ea6e4a7eb763b407d1df31f2483486df207914fab4d554e9357"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1730-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "2e780301079d11beccfeb5e7a73ca60fd983cab48000134f10e43a38d3e7faff"
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
