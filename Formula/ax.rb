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
  version "0.5.727-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.727-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2e085569febd16e1b2d50f3b552f3d3321b5b98097ba7eaf2e81409a5adb6b26"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.727-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fe3431bd984e393aa6a3b7c126472eee8a9d789669e9f88d3693fdd1a49c446a"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.727-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c61a12ce45a188019f135d1d459ddc263006d98e2f5d8dbae8b27c217adafac9"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.727-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ad77ac87bd6a64a498c53ed3170607f9406c92cd2c469885e57e2d743edbf2f0"
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
