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
  version "0.5.841-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.841-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8a18cdba4dcc02b30453af52695a4014a60f392bde9871a1564c9a13ce348017"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.841-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e198a3f38c7a657c817ff316c3588ba939bde5598b68f587d564407edfec0ba0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.841-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "629a8a1021be644dceff79e28ffd440946172fc1fc34f788349ed43173b44ad9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.841-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "84ba4df352e4e58b4e6efa9af9f4f44b8c6bc516e210dab0e9acc004ab667b0f"
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
