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
  version "0.5.1405-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1405-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e4f78fae35af220dc6292b0e41ba3b917941c896b42d1ef92b66bd07550c0a02"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1405-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9ec7c87bdc238f78e5b7053e3ecb80817fe389080a5df07d02313e5a670d9cb8"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1405-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "846940bac7dbc8d8cc825ae0ec2747fe0ead6213e8faac50dfdb53577faa6cc4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1405-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1d5ebc1220b92bb0e5902bb19139656efb48ad5df9c952a631784043bc6120f9"
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
