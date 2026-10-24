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
  version "0.5.1488-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1488-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "09664395097b5c0fa7c6f14531d0fd03f40450ff493abf6b5d2fea1168dacec4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1488-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "8f536a98bf09fe9649dbf8ba27fac7284accc9a707ab2990677e635f5094617e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1488-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5ad1baf6ea2fe96a2fe6fb2138926f86de99b7f338166ac5334ed9c302236593"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1488-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2ad6a3de639cde2dbd79389caddf03e0b6a407ce19b4a8ff85fad96002fd58b8"
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
