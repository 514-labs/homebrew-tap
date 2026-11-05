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
  version "0.5.1643-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1643-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "06a9511285277ab963525ccb53be57554456bb7250a747d1e3e419fe133e3887"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1643-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4459bb4f3f165a9656b021d6d8d459e9e906ab168b67086e5a32d08a53cc2629"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1643-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9fa3f7214f67179695cf672d0472ce0802acccdeb754668e2e719b14116740f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1643-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "826e60a900baf4a4616ada85d1e518ea8aaabebbba806446a3cd3963e7ad6c3f"
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
