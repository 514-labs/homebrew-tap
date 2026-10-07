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
  version "0.5.1276-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1276-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4271f5b9bf1c4cba8e91680143a7ccd4d24ee6994b2fe28d37d29dc3c351489d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1276-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "2de71d033744356efd3431108b8af75e37e81e250d86a0e140080a25960759c0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1276-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0c282af8c57afde05f995d31cc39884512388175e63db65f99757cc19c39b5b0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1276-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "91b58f13e71d094089df0b2af9a67561c54f3809847e00206e7256ac6a14af80"
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
