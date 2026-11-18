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
  version "0.5.1755-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1755-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "d994b3661a6b2261bbb9070946b37fa3efdba62443d7f64da1b55957d4dc9a81"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1755-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "04efdb7f752b2839788a06a8ace0cc33f6344d87ba1f404bc0d0aa80a8ec73ab"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1755-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "876c142730cbaa7d15a6b6a253fa1fcd841c38d53f5177f0e3e6afcc72b73505"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1755-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4b5c9df595b26f6f0e11d5b16988675088150898d95ea7a39fc47b8a142cdef0"
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
