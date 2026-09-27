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
  version "0.5.1155-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1155-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "0721fb97e719651d6bd74ec3a71cf2db93bf58d5bba73e3e7e82b33ecfd26893"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1155-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "37f4f96d34a628bd2bd59e47569ce44f375ee739001f708a39d90b808a2f5caa"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1155-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "86b1d88c5dcb6f3c8c2cfc1bf833e49deb7e88d27b3f2d2db9d5075b0564d094"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1155-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "71cfd20a0adee1942cbbe1d68340989928076eada3144b8b3d41dc251c4e4e04"
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
