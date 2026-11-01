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
  version "0.5.1623-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1623-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6c81c7e179aaf4cfbe23f0a13e2fd7ea31fc3f972f5ce679b7da3d3af57a6042"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1623-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "932a60ccf85908769c4487e4602786d7a7614b340990e961d1fba410f7e8a161"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1623-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "874e560a277eefc2cff93300439813cddbb41f978d00d06f055bc81398e1368e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1623-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f0607891627678b26e1a3026864fe526db61b2d3a1048583479229e9cc090c02"
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
