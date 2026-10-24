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
  version "0.5.1489-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1489-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "28df1ce01c2dc874538ed8a73aab79702c9fc2da9a2de4f76835ccbdeec7e11f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1489-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fdb1298ebfbf2d57dca47bf680cf25a0b4ba794bc948301084825a0268fa29d4"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1489-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d3a8ca6951e2f72094fa8445ed42e735b9e969b9541f97c58a418cfb89e6b622"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1489-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "397ac580734c6fecd9ccaa32e38acb250a7fefc6412acf7f5d63b7208191f6cc"
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
