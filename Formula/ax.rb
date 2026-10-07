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
  version "0.5.1277-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1277-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "25e90fb4a2dddd865be972630fe18fdac4f483d24b1424524c32486df2d9f7c9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1277-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ea45b6ad68d1853b8212f61e9348252768b2b08d6de51433a79acec42ca065c8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1277-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6df4f42416bb98217c8961b08eac8e469a93e12a03e4da0a2c85692c2a9ad2de"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1277-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3396dbfc9eeccd06464736ac40a7b26d971d4a14be6275f54a41f769cf015928"
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
