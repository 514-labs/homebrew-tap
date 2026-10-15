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
  version "0.5.1358-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1358-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "4e042054f4dd71dbdc67a875e09f636d838eb9bd753861a1ba22f2cd81139c14"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1358-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4baf2223557196b0bbec954173c1cf71b0806dbbbc53f2d272476710079ca5f3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1358-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "676ed99d2474ad5a4bfd27eed79643e9a2d9131793ccbaeb58555959ba7ae39a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1358-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9c9476523fc7476a6684ee6d84e7fce602d3870851e9e21133a92c7253f381c1"
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
