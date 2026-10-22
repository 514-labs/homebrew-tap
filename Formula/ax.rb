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
  version "0.5.1459-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1459-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "723ac22b3b996dd72da170270116047f495e51e662056f9fb07ef93498165b91"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1459-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a62753adebfe202e8f19e5d618f96e38a7db0f814840592472ddc191de81dbb6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1459-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a1b2e23d436333c71db903c69d23f0532bbad6d2b8d61f5ed33f73dcef65d1f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1459-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "14969064585405a04da23491e749c911fb668a91ecc77236d3496c55f19d6508"
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
