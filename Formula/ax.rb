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
  version "0.5.947-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.947-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e4e7e53d9340bfe454553c7f146cbc2e0dfa303a793a07e3a908ef70e243e3b7"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.947-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "0f46c23056dea1c60755f62af991bb87151f288e3770a2bbea5b32751833b0d9"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.947-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0a61677284c1d21c0198dce6589d73705ed9e4d487509b31e4c521e32ac80d8e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.947-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "856d3f7f31b72c50fe8ac2957c644c7c730a1a57ed6d8d1c788fcb6a9ceefdee"
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
