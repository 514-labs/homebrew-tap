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
  version "0.5.1441-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1441-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "643c6181176baaac15bc76d5e84c5e4e8c3be8866f8a3cc38dc7c1b7db8e77cc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1441-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "eafa0b6c8f1ff17400d3c74c97bc9fb76341779b0119303e34989c4eb7f2c2c2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1441-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f0660131db2e15cb64eaf07b739bead76c14f606f4a98bdfc4221f7689a1fcaa"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1441-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9aa03e4f74e8e44e34398f92e3f312d012e3e24477dd5c23213809fadf5a0e4"
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
