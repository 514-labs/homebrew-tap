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
  version "0.5.1627-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1627-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4e45b92b04a93e228455c84f1bdd39a2d5b6551071bb7cbf72afab7d4f9b7fca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1627-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bbdb75d553420b03ac5901340322e064946a278125a3a0742a8c486e6bf7bfa7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1627-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "326304262f8aad934eece1b3317f3ab6d9026788e3badc29897bcd5f9d9d93cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1627-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ac16080e297264f2d577756063cadea3987ed89f626d01fa43146782de99f1f6"
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
