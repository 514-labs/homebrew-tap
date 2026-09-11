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
  version "0.5.1035-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1035-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8f31a7086ac4dd817747592b4146c1d3db3f8a497c1fbd2bd1809ce999bc74fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1035-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "5da12f43ec426721bc76f165ac5d574cf5284b859b14c1bf71ad900c5ed408ce"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1035-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e627ceab188d85c1f45dfed84a38950159a332af08fc4651234c10e8145804d4"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1035-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "c4a51270958b81241bd1c0d2a2e75a57fe44643fea3c74f105cf6ac3fe316576"
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
