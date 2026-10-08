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
  version "0.5.1280-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1280-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "66b8a8adaf0863a2a76cd514a3a4352d6f5e292ff7a98a7b02417fdd7fccfa68"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1280-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3ace89f3ceb7fa07717edfa73fc6c79370e197f599869441f9b39cf66157e1a0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1280-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "63769d725f0c143e90eee16871fb1ad6ff19c796ef58d706dafbf8d194d26281"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1280-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b2cf55ec12f1336429e1d41b21cdb18a210242ef6896726e3b1be49c7e51145b"
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
