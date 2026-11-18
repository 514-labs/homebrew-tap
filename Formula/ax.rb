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
  version "0.5.1751-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1751-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "15c41ca47a6f8e81d624faf34502e97e48f88891c1fd79e6db393107ef8e7b17"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1751-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4f743217e8ea0802fa313f224e71d51ee2ae592cc7769113d6f7e31c5ac749b2"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1751-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "379bee8eccb7f309a2d1a252bb99ab3e3bdf7cac46fcb2c85d8a4257ea644a31"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1751-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9f9d05de67c19640e099f8cf69037784ee09cd596baef994382aca295b58b3ac"
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
