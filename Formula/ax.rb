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
  version "0.5.1452-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1452-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d5f48032bb0706ed46f10601507ea166ae100c909fb97df13c6aa4b5fdad4711"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1452-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a08768caddfe1635a996ad445c27778cd2abee92cdd373281282de87c56ee4c7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1452-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "85d07669a2f9d03b92bde60b7c02833bd71bd4a285aea2d8b40e18c7aa53cb61"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1452-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "000baf20b08a2919fc9bdff3f5c2e518b9105c5f729acd6ec3710fcb5a5b9602"
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
