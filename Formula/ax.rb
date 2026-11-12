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
  version "0.5.1724-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1724-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e5a9eabf0900d0c8af2fe7203aea9bfabbf27ceaac1820162b53f369a17d7026"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1724-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "563ffba76493ec10b3e9ff10f9674910778444b2f19b37b1c38070b4eae16a63"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1724-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e25b2a3a1fe7d292268d8e388fafd2fc58fdf030af39913a5477ec2b96393fd4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1724-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9150aa6c7a743e64e11ad923e23472107b79f820b62f0793676d63fc65bda76c"
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
