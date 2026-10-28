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
  version "0.5.1522-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1522-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "195979e2c4ddd38b5de9b7484b3e68cdae4a5c410a94f3db8c11d4f0468a8c86"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1522-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4e9ffad7bd4619421c6cf80916dab504573fc2b82438504a4815134c67de3002"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1522-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "bb8a10940153f08fc22f1307f74c10ca58831617e13e62181136033e6e8e6a0b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1522-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c7f8f20226b125088b7bbc7769038536f6a1ba28ac6e5ba8a9ea65deede11d4e"
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
