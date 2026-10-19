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
  version "0.5.1425-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1425-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8ba453d7b6e86af24bae4d2c1311a811b625f0698ab2a716a69d034107d3bb1d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1425-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b6063e24e8c061e8bd930aaf8cf547fef130597a35275d29e1de2bffc2c59da5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1425-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "820e9dd68742ca2e45327ffbff840e73fd9c92dafacc5c3c56176033b63d74f3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1425-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8ab91aac1e115da9b869e737922927e67dd0765daf34bfd08658d1d7ccc3dc4e"
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
