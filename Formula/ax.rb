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
  version "0.5.1297-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1297-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "daea73a4d7d230f96c2a25c5c020113b272371978d212b872e259513770ac031"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1297-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "496df7cf5f11958632a386ca8e7708079d252978c4ffa1f42cbf29047f045cd1"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1297-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "04a37542ee3de6ffcb45380a695b97052cea879dc5f8f430aec3d35afddfa2d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1297-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6f942e2136050959f165acf1c143e863205465b18622d0338572c43fe713d69c"
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
