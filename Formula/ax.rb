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
  version "0.5.1294-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1294-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3d785bdeabc7d4b3aa35f540869cbd426ad368b95d964afca0807e109da239c0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1294-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "6066fd7e9853fa5169b4f98d2764f4ddd482f9768faf865e7022082c47b6af41"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1294-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "afeb468ca3449a7be3c9e618041d206d0fba14284542a1e99069c0858a6ed369"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1294-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e8fd2e625130fc006fb8659ffc331d7d6671764dbf8c20f36dd14995aa6afe91"
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
