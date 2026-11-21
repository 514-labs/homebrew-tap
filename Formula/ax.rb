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
  version "0.5.1773-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1773-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "348a2e2721015eb6760a4b2e25c97eb269c926b1d604fee7b172e5003f8e72d9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1773-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "995834cc084ac72049cf334549ca94dce30bc0a87fe284b31298317b00392458"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1773-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a9d0c55e2a9bcc0944dd944d22f99e584ea68c2c36642b04e80e2c0af1a32929"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1773-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d58dc41fa990c6c668ba33ceeba0773fdecfb6dd54b3b733bbd791bda1667849"
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
