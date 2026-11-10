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
  version "0.5.1708-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1708-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9a95d2c98b3d388bb4a8994c1cf1ff455ec36a06a8c568dcbd79a714e73149dd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1708-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f99f118703e4af1ee46e117e3674967f54af8e1d6d7a91a57afbacef53095416"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1708-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c6f74ca66ce7ae54ac162d600f85c717f498f43219f82632762b60e5e5aef549"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1708-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "70617f1e77c3dcc298ea36fedf1484c42940b6bc7aa5512950e9fe7ab879c2e8"
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
