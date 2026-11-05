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
  version "0.5.1645-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1645-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "698babb40bb14797fddb489cf15d76273114775e7e844e8f7fd7b88a097c1d6d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1645-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9d6d46f15de7eb9e5815851661e7d4808f76d0aaea6eec0c4d62a2b17709d5e0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1645-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "967c53686a78a48e05eeab9c7423cfadbcfd4b056a04238ed0702902ecfc3727"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1645-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2bf61ff6e128b366b62d2a8251fe30ef1155a9358cb5611896e2611dda70f7b3"
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
