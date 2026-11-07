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
  version "0.5.1678-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1678-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "770e25e79239c0e19aceab74f5910eec28c5bdc09a923eebe00dd1648452cca0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1678-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "42dc48166c3830bea1f324f94f2bae6bf309397ef0a83634e45366248dabd94d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1678-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f1f9d916fa81ce55948c0fd9074f709591b7312332361a45ee1f6c3941a36ef1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1678-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9e96b5d3080e33082a940195af2dc27bf5ee967ec3ce9a40ae90f7a633e09695"
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
