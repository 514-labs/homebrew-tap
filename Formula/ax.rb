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
  version "0.5.1322-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1322-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7391477c6e32c8856dac0c3cf31ed4138bcd911c72401c30f26d27adb12e41f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1322-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "96ee383592cda49b404f8d64d25402e6b4c66dafc41a58cbe43eed61d34b09c1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1322-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "db30c5d628b01e0ee07f373368a395ef9de4cd15e26ef15cc670554e0279b050"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1322-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "82f203d23c287d0d63c22671857661044adf2551051de520f50f29fcc9a36a70"
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
