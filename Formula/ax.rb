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
  version "0.5.1317-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1317-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3dc65162e44073931a774fcb7e01d85b8df5efd6a20939805de9372c0b48f8a3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1317-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "235084d8777ce0e03f0008ef2cac7fef7cd273501500705cdb30999de5aa7129"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1317-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "876ce704203e2a198e7aed08bbec87e2cfe66c4b9f59ae09b0d735eb93d08837"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1317-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "857adb809cd829a497c5b7053cd6c2029bcbefa3d1709992d2cced70d6d546b6"
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
