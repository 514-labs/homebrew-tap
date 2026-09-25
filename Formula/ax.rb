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
  version "0.5.1143-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1143-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6cd56def02c2d87645132e483477aa64e7bc16082d005e942e4ed3ab41da0ac2"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1143-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "e174c60d424e61ac13186e589516de103c8ea4a35bac9e21b97c606939c4c754"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1143-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "670d1b64e5dd97819988c72f396e6e709c2f53626a55239aab76ddab4fd0db7e"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1143-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b18f7c839842b03720a8fe925e03fbde3b7dca561fb9e9969e38d8b7d56629ba"
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
