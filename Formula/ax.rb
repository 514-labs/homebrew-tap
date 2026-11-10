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
  version "0.5.1705-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1705-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "87452a732971cfd5680f62ffc7465c63821b1502545c682fee69be8edaaf9e0e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1705-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5e44197f788fb06289daba481c5e927132c8756125a2177437d176846f8c9a71"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1705-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "baffd28c81669b19149383fd7f3c41114312881817b61a93246b958cdd8bf2e4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1705-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "606c8dc7f8738bd67108dd1c538c92ca5b0e12cad277259eef3c3d35531ecdd1"
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
