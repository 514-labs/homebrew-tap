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
  version "0.5.1446-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1446-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "54795c3953dc6cffb397bbface3e0fa2409ebbb380bbd9d0f7f15fb098ebf4c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1446-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e63ae2f4653fc889c75eb37207a2e5ff497486e0e10e3b86302188803228d7c2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1446-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "583a725d19bb976153f76a77cf635750d2bee91259b102a7f6ee7c6aaf893e97"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1446-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c9dae0b59ffe3339db6262dfeca9914904989a4f3e15cb3d5dc5749b723edad3"
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
