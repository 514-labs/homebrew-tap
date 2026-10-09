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
  version "0.5.1305-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1305-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "538d4b917a28c5094c6e5f838bc2ba06a8e78bbc8e3a0bf96a219a93d064bab0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1305-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "1f1652852612fa64655e0b8dbe4b0b0aaf37ea5be004b92e3ed05fa687a2f30d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1305-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9121d7eba0ad0a1c5845b18c791b55b0fe59492ca7cb95a3ac3a5e76d883ef80"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1305-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1c0ddc5b51b4f5971d6d4b3895a90bc21f772bf09fea793d625b035cf2de5b36"
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
