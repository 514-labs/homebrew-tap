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
  version "0.5.815-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.815-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2b7d3dee4f9d390989087406f589f688fd4a04ed97fed98682622797d573a783"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.815-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "418a1f62245ca65bee2793af691d4c228671f4d1853da0f0f12856ecfbad70ff"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.815-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "2c767b7b8618db07d0db9215c045e8c82258ae38a97900c8c722ffecfbaaa8bc"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.815-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "81adb897e2a533ed11f185eea423f415e1b9222d4781095a6a70ceef4bfbc058"
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
