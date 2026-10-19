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
  version "0.5.1416-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1416-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1b9bdf316db0e0d3372395394876a328759401456a3c632af7872dc5e4ceff41"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1416-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f61fb31d68c09bac3fc9160f231934d9e4ebc1c2723e887324d1b45b67d5f4dc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1416-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ff36c446b918c9a32208899c4624edaafc1eb8c2cdbf343b42a786d2ef17d2bb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1416-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8a95643a920bab33c6a97657aefce17e60b6c09668aaae7350cf034d0e33fd48"
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
