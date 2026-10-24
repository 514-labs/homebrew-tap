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
  version "0.5.1487-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1487-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "485fe8d136aa2e8ac0448b2a8d6922eda02a615bc6132ce7553f4a3e24f067ad"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1487-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f8929f8076ba34acffc1a58bb90fe131b866394f1b6318b050322a7dcf43472b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1487-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0c47636693ad28df8446b91d2a0c32196cdc21741baf21af1b686f5fca0899b6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1487-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e6bcc26dd93d0e55282b1b966432f44cc856e2c00332d36d22b264eaa2534edc"
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
