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
  version "0.5.1046-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1046-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "a89cb6f9dc3dd8f6d723884bbcddb075c5212a0b47930b2c7d7b6f33367af19d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1046-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "68d89c218ad647d57c7f74f02035490589242d2fb6250e201a35196e8bed3d14"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1046-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a31079ccfb7c14ef51868c555307fff629ce56bec06bdaaa70b0221ab3ff92c2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1046-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "683c5409aee9c24bba29c259a555804c0bb6f3bc15dfd2566e7043bf54fb7f40"
    end
  end

  def install
    # brew fetched (and sha256-verified) the per-arch relocatable archive
    # (`ax.tar.gz` = `ax` + libduckdb sidecar). Install the
    # members into libexec so they stay adjacent for $ORIGIN / @loader_path,
    # then symlink the executable onto PATH.
    libexec.install Dir["*"]
    bin.install_symlink libexec/"ax"
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
    # Clear loader path vars so the test exercises the archive's rpath
    # ($ORIGIN / @loader_path) rather than a host LD_LIBRARY_PATH.
    ENV.delete("LD_LIBRARY_PATH")
    ENV.delete("DYLD_LIBRARY_PATH")
    ENV.delete("DYLD_FALLBACK_LIBRARY_PATH")
    ENV["AXP_NO_UPDATE_CHECK"] = "1"
    assert_match version.to_s, shell_output("#{bin}/ax --version")
  end
end
