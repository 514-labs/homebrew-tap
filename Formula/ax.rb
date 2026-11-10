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
  version "0.5.1707-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1707-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "44719a5488d1840d1a5b7353f30a99c326cb37a6b96ee59b1e2585d120f8662d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1707-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1fd78dd0bad75f25f9981c1eece9a20ac90d06902778c8e70eab5a736bfc20f9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1707-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "f6a7963ae500e79702cc892b2763e3641a9a74d649687c80bdec1b9d57c2ccbc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1707-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e0a03097daa2e348d8d4c1718c16bfe31e8f00687623ccdda9d6f7c5bc88dd23"
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
