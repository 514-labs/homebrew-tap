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
  version "0.5.1214-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1214-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "ce3e0019311e6b011dc795b6cc21b9c8d1f94895f93e14d06495f87c9768b557"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1214-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "b9af6288858be7fa10e44954534b3f239c27004bf44e3625846e39ade204c90f"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1214-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5f2b83375a8a0cd19fe3272656986846d3603c70732510b2c5076275f1d58e67"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1214-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "7326f02aae6c1bd093f1c0ecffc438dc0b52a7ab3c0b7e96c726b423c56a173f"
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
