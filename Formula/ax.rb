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
  version "0.5.1177-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1177-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "dc7a7aa78f3b64969a41efcc7931a3bbb9bf04b6c3fd82c3374f48b1f3868637"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1177-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "f64cc0e36f0ffa7cf6ecc87b19e21ee1197c91dde915e2e532f0a9e8025a849a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1177-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b37f256a70fa047ce23f68a0a9c9878ad03b457a322ba07bdb2550e0fdf23b2d"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1177-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "1c047b29c27f6a1d19e5cd36023730c6532a73b0d27cf723154ea52aaeb41b92"
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
