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
  version "0.5.1271-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1271-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9a815eddb8c05aebe5004ea28370c197a83c4db93a2c247a41a4fab5f35084d6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1271-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "60b0dc2e0cedcfdd9cf8f80499b77177a4737ab1f30cbd4198ab83b97f2ef549"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1271-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2b9b10c890fc727147abbafea9e240f49c0fa0b6356ab35f4953978fbdc1df07"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1271-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bae447fdeca676a7b6a01be990a380e97e443f87c9de22ff8bfec8b3753acf5b"
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
