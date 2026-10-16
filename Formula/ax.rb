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
  version "0.5.1392-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1392-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f116b0ac1f444e5daf2b541d6b174dbb1f5ef70e824f43d5be06ccdafed29304"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1392-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "95ae6ac586f46b85ead7f1dfce587087ca5107fcb29a0aad9be9d089a65918df"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1392-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1b23dc324bd77e7a24e6dad128404b15fdf18f40a1f7488c98725889bd9060f1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1392-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "df262e129beaa3132d410932d1f3b74b899458f7a1df75647c0672c533d1c013"
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
