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
  version "0.5.1608-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1608-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "90e158aed994769bbe495fd44c0cfc8670cef6703090219f601251271870fbc3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1608-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d645cbab6ff806c7055671a6566aafafe838dc58c3edb72e42590611ee30d91b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1608-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "acd313d3d3e06bb549a2d107497ec9a1653903eda7909255d155cb19f6ea9c17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1608-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4472a3831223b4280e2986d36f762b5fcaf12b58867b5adc240c4be6a4fbb834"
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
