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
  version "0.5.1638-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1638-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f7d87d2970d927d9042a4831f8d49d259a6562e5152e30e76734db1f2cb4ca57"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1638-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b4321b5c30fc5b029d0a91ff70bb7192787d1b3559bc218f28a73164e4fc2dcc"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1638-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "751c4fa781dc0b34ffe355364ba72e662b67ff22bc6f486647a2ff4ef898d8d7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1638-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "47fa980e7b85df88bd51ed455c5c171b1eef5dd6e559ebbbf4de8f2f188fc672"
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
