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
  version "0.5.1385-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1385-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3085968dc4a35746bfc20e1dd56e467b6670b936cf646e158102ede988d91aab"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1385-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d976b9761edab285e3c83c321cf3ce15ce427cc14abca04a4a7b05a3e622e8ff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1385-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9fe0708009f315d24468aa38c6ba410da81b4876aa938e1cd41704c804084447"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1385-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c55fa5e72a985d31f10c7451b48e9e8712b4ac676b9f0b58a180a15902331dfc"
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
