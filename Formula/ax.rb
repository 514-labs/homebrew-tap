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
  version "0.5.1710-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1710-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "16f767d95574e30214633508748e6ebcced7c767e41b286f5a195078fc0d2143"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1710-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "90913004671d3cc59a08ede26b8925629abd35957e7491e019c3d7c0673b3cc3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1710-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1f5f59e723d94898e607f46a8cad168fd3c80aedfcdd0466751effc0903da68f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1710-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2073caacb9bbb243caf825051ca955820b9a8c67fc586c49dda4e401bd89bdc8"
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
