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
  version "0.5.1220-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1220-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "47d2374b0392631bba7c7813f8c4c560dbfea85ad19bd62910eec229554b3b2f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1220-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "c05f32e2e7fcad63d6d44b97508835271b9d685d2df935802aeb8f12b97a9711"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1220-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b82c8fc11e63a26f38f72dd0eb21e9bcd79648a837a04a3087f2af47a7ee3bce"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1220-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "b8661efc85255a7879b08e197c66badf68fcaad06f03a89e569e346a2b1c323b"
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
