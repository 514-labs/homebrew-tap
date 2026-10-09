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
  version "0.5.1304-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1304-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "acbcad53eedc6aabb159a9b2c6298c8febb6402988be64df10ad25cea2f85989"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1304-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "01aeefa4dd6989953b123b35794cefb626982b0a5d6715a00a18c84d3411bc30"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1304-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dba945f62e312c40a81e15bd961a2428068afe7116a223040f41af5c8091dd7a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1304-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2f4192995093838974bf1df16fda26611657a2a0cb6798016fda0fe895fe6210"
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
