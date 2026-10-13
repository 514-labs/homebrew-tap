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
  version "0.5.1340-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1340-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "03e0cca11d6dda804ad117da6627e7863d0283beb30a248a4aad0068c7ad4a51"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1340-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4855fdfa08836e43cd47e1e8c3dbc2b5bbe09d70e70d7d994e63af71aaf70dc2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1340-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "846b5398c659aaa0dc9e2af15067c66c08b94bc0d259f60f400c90c68c981ad6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1340-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "103cc173962ced69fdb76a89cf43970cb2813ab954df144cb313fed6f060d936"
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
