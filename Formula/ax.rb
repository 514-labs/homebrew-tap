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
  version "0.5.902-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.902-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "5f533ed136449a4d62e0acfb885ee8a0302c3c823080c6762d3e8da028b53447"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.902-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "28af0e4115186befcafc42f3a5e464380df540bb0db3d105c3897f682b647279"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.902-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e82cac1561779189d6f3e28cc667efea9abb88935cd479649e2c0d312ddf5833"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.902-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "3b49ed20a97d362fd883970759454b060430f16cfa5db8eaf4e989dd3df1b832"
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
