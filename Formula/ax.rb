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
  version "0.5.1433-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1433-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1f7cb437ac24c35929268b10fac62caa84dc8a7d044a970e9853c2e161b209dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1433-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "335b685f5c6f39049f6a366d3aefcbde2f4d306d9c58e42324e5765c0343427c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1433-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6cae1c10bee009c9a5d77809b3fa32cd0349ea4a2c45284a2f684e6c62804dcc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1433-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "52da20e9db230ec8468ced74e41961448b48354f9152757d17b94a24336d625b"
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
