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
  version "0.5.1380-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1380-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8ecb43f399fea96cf76a64c45ddb307c07a074d68a7178599d27fc15d77f4b56"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1380-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6705df23313f5cb6dca364e2a4f306ad83d4c45425e27da48b841a32da39483d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1380-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "32123038d1e8edf0f3ecd8cedf259b256928638d81d347b5c5972ea87c3f0f4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1380-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "552b26e6f26d941436e9c585fd933580c48786399e9b4e02b8cf138067ad3313"
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
