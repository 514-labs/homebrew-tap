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
  version "0.5.1768-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1768-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "bc877027bce65ccc767d07dfbda9b473e0255b86f483784082d200d18d8b24ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1768-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8c8f491d301d84448ab4df34fc0069de0e3c91927946acf8dab8bac5c58f7ba8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1768-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "88ae4e4e684a340086f19e05ae907b7d168a13e3fba59cd5f33788ef87ac45c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1768-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "da8ff206fb9644b7f57609e11790b74dd7b1d67be89b870b94509f85988aec64"
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
