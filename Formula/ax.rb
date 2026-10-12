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
  version "0.5.1326-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1326-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ef2a9a5d8f2e01047ab3481c110daab276e7ee0b6eb429c7ac5e0a2ae3b63ef0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1326-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0d5444762ce7ce8e170d0ca6492d8ca45228c3aa9d339460db671184f4cc0bc5"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1326-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "fcb8e6811f6614d16f0f7fcc986be776a8f8dd9105d60176762ccf79bd9df4d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1326-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "54421f0c7a71286b1b2a936b1cee0b5677d00b5846c38902914946fcdb9b9198"
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
