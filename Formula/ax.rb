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
  version "0.5.1263-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1263-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "42770acd27438203fd9042899047bfe826bbe2891736a46dc36edfc3439a30cd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1263-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "128e86c7f8573ce1ead3349068005cc371f4885270d68eec0c68062f41392a5b"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1263-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "82037678a5463a8bcb54aec6d17a46b4e4952994615e1254de3da3a01d95aecd"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1263-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "46eef5b6aaf02abdfee86adddd6300f773e3cf2dc828c5f4ba2078c0b5889433"
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
