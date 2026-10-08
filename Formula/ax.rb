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
  version "0.5.1284-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1284-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8d735c67b2c2f4cedf756edc0571ae635a43a9aad814fe98d7cc5433add8c581"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1284-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f36da8c5b706dea674a2144507bccd44081b171538af749674ed592303c27e01"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1284-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "821c808fc86d01c85a730a3f14af3907f4614c547ff3cce7ea77af7b1df802bb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1284-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5981ab64c12983d0ccbb3b9faf992ceb6ff5ffaa51e19888c422c3a2a2985100"
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
