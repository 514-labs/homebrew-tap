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
  version "0.5.1213-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1213-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2f9dac27b2fed11148be426a2d1d5af7d9c455cf51ef9d7bd34c1747349cf00c"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1213-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "fd89ea6e6c93746856e4f7d9b97465206d20326247349543c9643ea07467d62c"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1213-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "ddc06e0b753784cd8a1a69f936271dba662bc02feadd0142ae0eb6a72186ca84"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1213-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "cd0f6502772b8422884ec19b22ce525a341190e0f4279b6986120b895fb685c9"
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
