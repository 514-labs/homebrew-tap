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
  version "0.5.1786-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1786-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6f2dc56f25f9b7e52eefe2752704c1096fc6e11fcfd8629b8e7fa0b76b95b963"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1786-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "d2c5f60f97dfda6f6bb807b4b8da24703b5c1841c37871b73da3514a35bcbb36"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1786-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b45bb6ddd197c53394be1c2eba4e83681b89479cb3088b5675aab64e129947e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1786-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "180d8c09f9ce9052b3f9cfc7c03d5f286098e317e1d5e5e0509fbb5ae5103caf"
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
