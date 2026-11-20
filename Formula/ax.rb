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
  version "0.5.1766-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1766-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "55b3e83a1daa24ee0ba0acdcf6195b539900a58c8f3754178ba29e38777b36ea"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1766-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "30d981172f521de1ae99575854acba3c63a6641d71ce5e84ffa6b1fa41a45b3a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1766-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "77742a907a54bb2a8edc7d483ed72378e746379d0646fc284e97d37b67a57048"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1766-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ee76aa30548e0dbc21c02bcffaf08ab2a0262687feeb40a3faa832fc768ad99d"
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
