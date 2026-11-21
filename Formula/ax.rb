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
  version "0.5.1778-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1778-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "78e3d9531df6238c409f02b534ff7d476f17f21ccae063a95ae84b94f9a68ec3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1778-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f14e1eade651c9edb7b786ebacfba18c51937dc204950a66e50bc2421c027792"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1778-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ef6353c67d2b82c5593546887f63eda40af3eac4cdfcc323eedcf269d8186fbd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1778-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1f0ddb015f304cb1eeba6a38f6719364f9224800fddfb80a7410da0982a79de8"
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
