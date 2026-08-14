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
  version "0.5.795-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.795-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "c0c71267c1dc402cc41e214db252a5ce25b89ebee585663c110f7158a57733f0"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.795-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "610fe9af001b370ac864d2b38715a1c4d1848427266ab82923795f9906c2d68e"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.795-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "a6a091e680e12fbc5335e1a1f9927365b52f134d4ed579275d7acde56c7bf92a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.795-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "d6a211ad047e107e00b8668503e334167c8117b30d93d5c43a5195023e4ccdf2"
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
