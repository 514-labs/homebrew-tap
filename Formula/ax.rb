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
  version "0.5.1785-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1785-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "10c9b8aa1aacff6cc23f879391cb73be4d0bccff0e50f9be727a7859a930676a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1785-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5918b20206428d9e73dc8e4d6f6ed2c46d47f0bee52bc4b0daa7c0b48f6569e3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1785-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6c43db7e0f20627819069336c2361dec4b17165a1d1106fcbb8b6e7fafff33e5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1785-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8daecc2f0c53ae4ce529484b5d981b9b13ea473d82533799a4eff6d410ac2eb"
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
