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
  version "0.5.1406-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1406-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "03f8b7013b8daf95a7df06979a6421d7a3fe4d16df2ce73e9967fab139adb84e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1406-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1b58c4e96ca98c098215674645623a885eb8b7f60ac36c42dd697787957115d6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1406-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6a17f5309363656b5e13c6ca1369283cbd6b616f0f459ee4163c15f3b1bfea52"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1406-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "be7809908f6cfb70f81eb3486424e2c40b0c4ab531459847f25ec325e51bf5e0"
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
