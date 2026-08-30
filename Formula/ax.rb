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
  version "0.5.942-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.942-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "3fccac4e2520ac6156665329dc021a0b0d5ca6b8cd0a51410b19329a3d7fefe3"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.942-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "4193d33a5f63897290f3a811627e4a99bd6a9f61c44b7123d4ad96753cd8e3ba"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.942-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "0da15a37a644c2a0d0b4d40147793b885b401ce67de33cf10a771d834fffd7a6"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.942-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "554c8466a658b4c5581aa5ba02290cbcc86d7d83193651cc89525049b54c3e44"
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
