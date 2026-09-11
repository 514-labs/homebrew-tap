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
  version "0.5.1028-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1028-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8478b0e2c81a7b5150981995ca9f46ee642c5d19ff2281d9ff1e495034da665a"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1028-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "33e5fc5eef23a42476eaeebe0e2c4727aa36156970abc3eb1af17f36e2708e55"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1028-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e79627a61efec90e3eb9d4ab56e9f2bf72f98b6e430d7aec1b5bb26cc890f896"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1028-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5aae08240f0816ca2d3aa062cbfb05a86fda99cff1f25a8dff236f4a103b4664"
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
