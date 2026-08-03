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
  version "0.5.609-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.609-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "9092817cdf9430fbf5128480dabc339f01a04d9f9288e68d41bb32ae9a25cb07"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.609-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "a4f17509b637e97c47c580b84d7c0b969af7823c0e34cb2d90b825adc7856111"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.609-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b6fc138c1917d638e943e16d1a844150fc9eb4841ae1f7c6ad03882ad0570932"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.609-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "539dbf084650e5cb86e5034949b63444b4574e165835074034eaea44150920d1"
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

      Next: walk your first experiment with `ax learn quickstart`

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
