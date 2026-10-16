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
  version "0.5.1391-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1391-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0527c541b3a6e5e3d8b8d7b41fe096b2e69913bb608be3c37651a3e7df11fc5a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1391-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "99410b154f016f6c202a845e94f2dd8f27130646c1b19d87918f8f4df52a7a47"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1391-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bd6bc8fd43f453493efb0320b3319a8d73cdff8ce96361a88cd44aca6d5b80b4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1391-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5be8271d00fe1950ea3febf22423e42abf847d2db4826b6eba710b2d7ac2effb"
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
