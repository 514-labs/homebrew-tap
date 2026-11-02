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
  version "0.5.1626-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1626-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "320373134d3881df5191887209e03550a084371ef33cc1330474efd078ff29c5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1626-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "de6ddc8d3c7c48c56bfc457198087e6696249720c855fc8eba069643ca30d675"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1626-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a22e0e48afaf76acdb1ba7d848efd3037951a786ef5a2accc5bd803be4bd32d2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1626-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8dd9b7ab56536b8557f2254f1e782162fc3f708f2a0b81cf1a4093ae0f5c6be7"
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
