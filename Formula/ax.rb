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
  version "0.5.1338-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1338-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "7bcaad0022f7575bc4a8e8eb3db6e81035faa6ad0a8fc0762fd4260f8c06c11d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1338-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "81a2961cc0372ef2e182e82ed5d08162113f160129b5db3cdf49a06e9707a849"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1338-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bae7224090df299006a5456a2c563be4f81c0597e3d310a30dbfa56fc040908f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1338-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "21277cb7bbdfa2279c0408576cf5df1cb8e0aa9f1820ac85dc07ea82c901e5ad"
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
