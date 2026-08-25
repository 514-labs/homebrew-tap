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
  version "0.5.865-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.865-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "e735897985e9f94de2af9bf21c4ae8d35f3227be8eae71feab91dc9d834a727b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.865-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "dbf7cfabd12823a54ab033b47517e1db53e231361c66c22fb8e58a5071048cc0"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.865-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "38b0652b466786cee494667944a4d7cb7ee33db376db397f5cd225fae4fb4964"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.865-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "4569442d50d21c9998ebd39dee96554b7695714ddad142eff6219a0510e24ac5"
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
