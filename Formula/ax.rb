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
  version "0.5.1226-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1226-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "71f990bce296bdcd668e33bbe31f02c7d065a06d62082aa8ea139c884abe6549"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1226-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0b928c559370656cc1d4bae07241abf06e7b1f0155a072b65a0b1f230e22844b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1226-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "be3b09a811b35efb9e6a4a0b9e836ea9a2d768e4f1d0cd5ed2ebf088ce5c3fdb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1226-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8d5f3b8ea86ec5e2192b8392f722c13123beb979a6408008c6ffaee76a851225"
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
