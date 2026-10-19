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
  version "0.5.1413-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1413-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e2d696f8405f4c219dab2178a13cd4ae9b0e9799ccb53221f62970d84091a3ca"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1413-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "ffc9af4925ea24e66b829fdd0ffd8a1a2dd768cb0ea83deca17d465d53a86cc7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1413-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2975d9d0db5cfebbf9138bea2a0fefa10d9184452d0dd39d97fab70686452a5f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1413-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "002d65a0b1431b0002d94d07c302c415f9a19650f9e1ad6cdb30af31caa13588"
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
