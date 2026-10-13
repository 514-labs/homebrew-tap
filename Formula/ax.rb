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
  version "0.5.1337-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1337-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "47b62989a4951a3789a2c24407b4d2b2ae1dc0865ad332fc1400494d38dcf897"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1337-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4e5afd1e14cc4d2bfb535c322933f131e549d12b27d43771bb931f75a423595d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1337-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e992ff80d8542c392c80150c3f0aa842b9c75054454a339d198b526458360e6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1337-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9666f5af02022036cc1dd51d495cfffbae4c5b6b76f66bf3730cb588de696c4c"
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
