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
  version "0.5.1681-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1681-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8735947f7f970cac74ec45b94d922d25b6aa44ef23cd041946ba335f155200b3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1681-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5b458b7890ba3ef985abd59164cce19fff1a805e1a08b4b3a90bcc8441d2dd2f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1681-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1569241f370ce63251c3625508a3ff952b63d08400d0afe07d5d7c9231f4d8bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1681-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "45f68c35a99f7397c1702ff45adc98a034c6f89dcf08eb8eccf31ba809863b5e"
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
