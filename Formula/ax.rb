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
  version "0.5.1275-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1275-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0214abbf9654e3535ea2e3bc8aaf54acea44dc8c428d175a0ac770b0a6421fc8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1275-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4785873d16ae258bd36fa645cf89aa7bf9d44fc2272f09a8962040904cb1b800"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1275-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1d8e046e96747bd5d7eea1c0bbce6ccb50d3232d39bbe14b9ea5340c46c5e52d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1275-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3759a9366d61522348c712ce265657b096d0937944a1f152a8b161a31ee9c07f"
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
