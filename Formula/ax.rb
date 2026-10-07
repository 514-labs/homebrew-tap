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
  version "0.5.1261-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1261-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "b589aedd104a1633bf892b208f2bc97ab8ac8ce8a58225addff7247195451b3a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1261-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5b11b0f715d740b60f04cd4192551c47459bb3132e3be6febe47ba8ef75e338f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1261-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c8cb8dd5a24290d863f7998c40ba358f459b3d5375dfc310ba4bede7bbeb4b08"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1261-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b6018c4acd84523026dd263cb847513e432c935707c302cd7965e069f6401598"
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
