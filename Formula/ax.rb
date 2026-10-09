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
  version "0.5.1306-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1306-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "48fd30bd7d7124f322d36ab6135e329fdd529913e33fa5911ea38078c038b146"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1306-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "600afe7c2daefeaf7724ede36e7e7af92c228ca17f9e33b0188cd355b938059f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1306-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5693466691da6ffceb5858f5850ae9f6a99221af49edca8deedcea713f1041ba"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1306-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "37e5289052c511534494daab96a9e68d0c21447bcee7feff4fcff56692248632"
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
