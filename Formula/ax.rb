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
  version "0.5.1632-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1632-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "69cd8812d932a20e2b040fd3db9671660b7a151561b83ccab0ac24b6e8b161e0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1632-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c058c2282021580ad6222682a36d08d75ff169276d834209ab50d054ccc901bd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1632-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "310f0eb8896ad4adb949c38e01031db441fe00b89cd3987cc3433291d505db85"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1632-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e9f3b297c46a219b05a4fb262b7ad61d0e28588ecbf5c96b2a0ebec61278e8ba"
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
