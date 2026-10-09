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
  version "0.5.1308-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1308-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a076718ca4e09d9228e0ce6997e52be64818b61512c88bb2144a2f5181f221b1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1308-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3e12e7f7e398ae0113418cc8c35f731f6119cbae90e34a660c0600cb79669425"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1308-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fc2a8e3b7a2c71704d23f73ca3eccc9125992ff82a311128d868e9ef7f14f6d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1308-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "58998010c39882594a00abe5fa6b594f2cbfd08e731ec2c4ef3051e4b3d16efa"
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
