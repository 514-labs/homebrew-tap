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
  version "0.5.1526-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1526-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d4d33005820c8f3e6947fd87d1b131b302a577b05d190bc2979d8173fb066cb4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1526-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "43e898902efaf155ab51b9af776dc29f9358bd29ac2ad1bf2870a81c2d83b956"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1526-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e528d2b2125f1ec2d0f199d417f9e34783b43259216d8f0400b929420eca0822"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1526-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9704f350da1c01f14650cc9ce38deb39918705523948545b77411e69dc570774"
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
