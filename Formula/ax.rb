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
  version "0.5.1748-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1748-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8c25253a3b7c50eb620acf813b02118ce1754845a5d8a030fb811c16e0a5d8b1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1748-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4b680b27e652f8482ea44f5103eeb1dae2bd79325feafaae41519b456ea59f43"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1748-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fce1af4a4d96e9f01c95a161d967f6da560cebeef1aec8a5ca2fd6c8e85d7d61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1748-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0eaa273fc079dc18f78038d862c9eb8ed657669628ef87dff758879eed6a5b1d"
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
