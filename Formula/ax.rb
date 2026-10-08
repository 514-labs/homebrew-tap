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
  version "0.5.1286-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1286-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2abb371f9fe8689aef7aac6c4087fc01ea3fc9d54ef53270789d0925cbdf8fb5"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1286-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "3d8127958885c2ca7a712d8b3cb5445c936b902ec0d2047125d4dff0323d19d7"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1286-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "23bdbd0f94dc833301152e23e410e1cdb619024318672612a7d05a46eef12bbb"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1286-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b09539dc735ec510cf8dd7e9c027dbdafd97a266bf90c3782dc05261b23b355a"
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
