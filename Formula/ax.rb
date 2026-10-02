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
  version "0.5.1233-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1233-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3b40f685bb38d7b07c506503ff0a9e96faf8ad0e9d2833d35b13181733cb9d45"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1233-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "86c17cf75c73a884bcc718dfbb0f80cc87e87714b3150c9f4ac463e922bd14a3"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1233-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "954da6a67f1b396f255e0dc6055bddf6e2b08e57331d4e1bdb106b280b35c89a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1233-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "258730442e8335362deb2a39999d8ad1f98350ec375bc7ac4acd463950dd7471"
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
