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
  version "0.5.1509-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1509-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "263dc35b98d86c585c4584a94561fe768bb97d99eead0786958d423fc0325874"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1509-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "77f37088cad70144ee7497b4e24eb2818696dddd9d0c281de6218fd4ed1234a6"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1509-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6a60c2dfc6baeb50a7d2ec36f94f0b7b873b7b5fd404709d5e40c072bb636626"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1509-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "65d0d549fd859f75141e2e1445e92a900509d91d6bfa4540822c62f31d43a3f3"
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
