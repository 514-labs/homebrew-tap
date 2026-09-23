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
  version "0.5.1106-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1106-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "61810e49ea268849dde1b8ba91882c2b043986105115e9a69abea927128d7082"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1106-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "13df077828a0c6ae2bf7b9dac3cf3e246b12911f8aa0d29dff4a53427f0cbd46"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1106-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ab46c5ba7b816621fee4cd6c8897fe0f6d1ea8680d9a300cb2c4cdc2c10b7706"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1106-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "59b86c457e76f4680e863e60819e3d2e151b1bfa5d0c1975b6286138b640cb17"
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
