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
  version "0.5.1320-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1320-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "eb971a2b8c5ad0f8721daaaef59952a732e6a6bd3e28ca815e616bedc6cd61ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1320-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5584c7acda24825fc6b02ea86f7cfcbb50a92da6382864ceb2c07d7b893bd77e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1320-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ce76c64a9c7d1ad1acf525d6e36e53432616ae5f49244b151483ddbeca28b31b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1320-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "dee220e0bdfa456df0f87f1921fc37a945e461806cd0d544223f8b674864296f"
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
