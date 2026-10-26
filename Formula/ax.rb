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
  version "0.5.1493-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1493-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "fd2f5c14f2f287c9aa0c85418f73fed4488d68bbb332bfff2e9c1c8927a5cc3a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1493-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "05c6822ba74c30cd605dd9e7cb80e1f3ff04b6b660c77572215e5b7f308a13fa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1493-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "161908447eb090848933dd43d62e5ea4e473dac08a27540efc50fa1d02936e4c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1493-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "aceaf8d3bdf816895c54d54c4f92c45083b23d95617e93bc33793f94544420e9"
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
