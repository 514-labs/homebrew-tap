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
  version "0.5.1680-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1680-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "475504c824962a34c49b09bb0a253f0cf69961850dd5d1cfa2b41558ba374a0c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1680-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "65c2eb90247b522a61367bd666f49d4b696c1f10bf660002f1249b223c775023"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1680-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1d42e74b8f855f35c97daa35dd815f4d22aaf41801f11dc35c26ea49b26e75ed"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1680-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8b7c99f088b156f919a0ec299111114a33f79d8034297c6aba76f625bfbfb05a"
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
