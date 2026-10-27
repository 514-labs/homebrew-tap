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
  version "0.5.1497-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1497-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ff7b6007a24f7577e981e2eb3be6fe5746697945055dbf884e5e8c7a0af6bf33"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1497-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a8489cfc85fd0cc3d93066e6017e9f96f2f47974993ab16581622a6b3021fc48"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1497-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c09737bd910d916b40c6ea9fc26b185785b6d9bac7f4f20805f9e8b1938eb860"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1497-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1c6d73370759d93387d3158d8af0d54db619d207f3d48334aacc5fc5bbdef204"
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
