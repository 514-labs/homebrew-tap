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
  version "0.5.1692-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1692-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f1f8df5767ed4d0e233b8b479a5f3cbb4b691c5bdff627d2aa7b9a8519bd73b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1692-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1bd19a3f675e749f18f2f504fac18836aa765f51379e5a233aad5718ed8e9c30"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1692-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "eadd3915bc02882bd3cc67a1be54d4b1d50839cdd69facd28318bd76ea5dcc65"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1692-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0539c2306a78873454aac11c984701df69457160699bbc385d73282b9619780a"
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
