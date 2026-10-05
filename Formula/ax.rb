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
  version "0.5.1250-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1250-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2ece7995e5800b123872e025e38b9db3fc74e8d5a0058b65ce74e274bbaa68ef"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1250-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8dfa976ce22d0911f53e6a3f417fedc2c3f01ab097546ebab6f1ca6e698c9944"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1250-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f1b20159bb38fc98402e79d85738f8c2f952d7c1c3fa6cc4d9688ae7f9305b20"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1250-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "55fd32dba414715ce2a5e73e4a5e8791056875244f8f1c69fd5801f2c2ef9a39"
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
