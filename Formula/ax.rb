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
  version "0.5.1450-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1450-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "98877f535e7b61d0a670733422cd0e2932864f875fe6cfac638d1bd7f5a5db92"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1450-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "9c7458f93315614484bb6b2bccbf5b1b91486a55815d24a30c9353ce04dac66d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1450-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8e24e714185aa7a7a1cf592703a0ccfaceab2cbc9f5afb30cbc951a7d9819680"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1450-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9423a08a039f28047226af049487bbb73c9decbeadfc4f37089e659099bc69ba"
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
