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
  version "0.5.1481-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1481-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f426a408be4e0ab1adba4d97ca133e4b4c13fc12484b44e653454a35198d7e30"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1481-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4cb3ec9ea4a873b3d9d9d412f5d9a4e17fcb644b0126d4fdfda5de026db0dda0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1481-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b282f2b1865b841d3fb48af7a6a298556514aea1648d1480df1e95a95a7c63d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1481-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "60aaa4ddf53dc18bd217d2190491e366701f5b00a5d4c086d34b513279702040"
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
