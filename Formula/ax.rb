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
  version "0.5.1228-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1228-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0f0e19f21ed51638c2bc1809976da443e8adba7439f37b6a6c2a148b6d80f917"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1228-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "30b046801310bb9543d083f69b92f1f4c94302cb39a7ea64731313aac0e161d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1228-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "01ef73d8f5f337fecfa913764de697863d94ce9276e459b81887d500dd8a38bf"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1228-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ef2a3489b131c1d3792cc77f3ab1cadc87218fdb8af3e5120eceb0f601b6e59a"
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
