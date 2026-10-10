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
  version "0.5.1316-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1316-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2afbc945fa1d418cb4e4d2b1387348798f9773585ba40eae1ef7bec3444444d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1316-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "87b2db74be679b24794b107e1a308411c012d23629b02361d2f9ec92eb7ff5e7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1316-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9fbf155116213ed0f7b542dfd37b814317cc34607455e53a4bd97ae925415f8d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1316-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "89e887e097b50831176ae8fd736e24d77d06451567cc73a6b25703b1d549f630"
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
