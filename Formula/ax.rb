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
  version "0.5.1535-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1535-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8a0ebd5a1cd9b738cfff837d62bbeedd5b04728cf5caabbe24f0cb0696fee810"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1535-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "04450db5c4d11c46e608eed1afa6cf45bfe86f84c426798c980c96e12f96a809"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1535-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cdf2c484fba83d4f82689fe65f90f7cd847be55fa6cf7ced531d9dc9630d5fee"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1535-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e689455259001fdaa9461543e946bf8ac029159464809aa1abf0d5b11285ad51"
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
