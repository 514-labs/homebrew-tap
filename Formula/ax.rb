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
  version "0.5.1401-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1401-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b4fdb82b01579d4c12050d385b5312ea60f131ae92f8185aec0bb0d11ee12b1b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1401-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c80fecb2304adf471097d8754862d1dc79e24d215f30923974dc272ce5159b2b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1401-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c8817f12a19cc2ead37905f3d9b4313355092d4e27d8bd1bb2f132ba310d3ddd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1401-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3def024b9eef33d18bd2860affad63e60c481dc2e0c01f0c8416844bf479c77a"
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
