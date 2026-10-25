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
  version "0.5.1491-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1491-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c25fbd996adc35308ba3ef9ba710d1795d43865ec88383a56fbbc55ea61b4db9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1491-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3abc117eedfa9e10aa02f706bb137c335eb1536883ccdf74ac90b0e98c929f19"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1491-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "93367239688ab389ad0e960d49e54bcddb1bc4143896ad7fe2d4f0b9999c50c7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1491-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "baf32009b261bdeb2c04cd0bf2c04fea8884bf30c8dfc4fb87823cd572e2f511"
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
