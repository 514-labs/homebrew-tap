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
  version "0.5.986-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.986-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "2a9ee48befca423d6c0c72dc0ff465f3906b01b7d80a4c0efe32d569b80d0eb1"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.986-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "17a0a75bc09023babcc0e05b3f25abe0839014d000d666d9335313bc67a8a1ef"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.986-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "9f21703158f70501528093ba3744425340afd6793bb6a9dc4cf8b098bffb2908"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.986-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "36182ec5bb848df9558d9f54ceacc1239e93573e398ba2788212798b0d3e6471"
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
