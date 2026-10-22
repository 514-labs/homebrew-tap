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
  version "0.5.1451-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1451-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "f2c58bb64cb999c5e82b8691ed61eba95e2a905b47ad2e751d2f3e22eeeb93cb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1451-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fa86f269cb0badb544b248c395b10c669e87ca96de699ecba2e147c509d1be5f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1451-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bc49189ff1a46da77709cda48444459c00b69528b5170e35338462b6f7a4458b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1451-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "199b2a12979f80ce8a21642c3af90d06dc0b690c3f31098a245c5eb0f9095739"
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
