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
  version "0.5.1229-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1229-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8f1ab8b791efd97c28fe131fca851596f68358407b6fdbb85d6862b34ae9f3f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1229-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "12ce22b9254c428ba454cfec4f6f1e886c6fe53431e1da5dd78f15202009ec34"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1229-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8ff2dacbdd408a79b2ea459f782851e7b11219465f86882aa32ec8770b32b6b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1229-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fbfb4aab76b6f2d397750cb43a46577272f4e1591d7a0049686dcebc5b22c55f"
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
