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
  version "0.5.1058-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.1058-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "1ac2b0b80051e5b8bf638cbb9bbe8f083b615ea5a24de9a138f15d103294d6a8"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1058-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "36dc66bcff56b02c26e372ead8630f92d9081b5ebab1b22cdef6e9b9fdc22b85"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.1058-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "baa5b237caf104bbb4e0bfe2026546e5993924679c907a5d5dbf38eb11a87f8b"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.1058-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "5e3a084edde600b2dcd6f94b766922e25973701657339f368542fb19e9e012ce"
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
