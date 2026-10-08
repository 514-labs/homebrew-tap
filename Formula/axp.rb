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
  version "0.5.1291-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1291-rp/aarch64-apple-darwin/axp.tar.gz"
      sha256 "af074f8ff6cb71d8b4efa18323138f207543195392f20f45b10a249851617ac6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1291-rp/x86_64-apple-darwin/axp.tar.gz"
      sha256 "687b1ef8ea12da85dfa7825b9f9867807181c6a23a2e01711d0b077615a59246"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1291-rp/aarch64-unknown-linux-gnu/axp.tar.gz"
      sha256 "80fb66d68d5aec400fb7c39003eaabc65f5c3ab7ff528aec8c4b9cc9047d956e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1291-rp/x86_64-unknown-linux-gnu/axp.tar.gz"
      sha256 "a4705b0a19684c00f172e36bdd7da5af522042784f0906ee11f33aac08d5cc70"
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
