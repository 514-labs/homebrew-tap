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
  version "0.5.1511-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1511-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dcf3d7380443d1fe6c549f9411f56da3ed3da266ea2ddbf308b105a60812f609"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1511-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3cce18bdd417eaebca4999734df2180b868bd0f3c846bca8a1b3a5dec1bfff31"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1511-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1131ab10c98eb40a82a1f3059805f067885b1f7a0d287696d5f9904ad06d8557"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1511-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "74270a54af403dac47f11f4dbd257e0506469123ee2d7f9b14487e7b6c21ee13"
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
