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
  version "0.5.1651-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1651-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "eb1c67138078b920432dc75b4193ed6c92a80eadd0df06058e31130c3e18ea7c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1651-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a836d2fb4ce09aa2defb4fdf69467d506df66508bd0cb955bb82110664fc71d7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1651-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c3ad4c51437f54e5c1ba7d76fdd2398e7ae0c86ee22594f3a98781020921644b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1651-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e0985d604cd887a2c32b787d69599e8bd447f6b86939270d13808740b579f9e5"
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
