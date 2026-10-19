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
  version "0.5.1417-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1417-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3315af3509c44e2b5c315cd97b8954ea691c337e6fddcdd97fc2a55380554936"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1417-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6ddc5299bafd48094799501aa3c6bcb73545c662b183e258e2ed02f43d6c1bec"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1417-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7c75df281d60dd4fe4e06c5cca1853c5fbf18aee457cb00afda1f63d41038f60"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1417-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "94a324022cf56c704cda6b45bd3c973e98cadbd4c1b2046a1f41a1cdd056293b"
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
