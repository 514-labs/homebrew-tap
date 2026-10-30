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
  version "0.5.1545-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1545-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71d36b0b3d4c7392c4a38e98356a3f92600fea0e248a1227e43b71fb5721c129"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1545-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "bae4be61470207cff7ab659dfa3aa480474e52ce2c7644f5858e83165bf877a0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1545-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "39a33accda479d6cf19f291031ee1e25d28ec571a8a6a7f092640accbba57ae3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1545-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fceb576aea0a2eaf6b77a6d6e0893cafd243ed97cb7ae1f0b4983bd701c12e7e"
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
