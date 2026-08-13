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
  version "0.5.762-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.762-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "8e7b74a17982a2f5a0d29a70d91ef46a163b725ea086090b4b220bba37719715"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.762-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "17789b09a8afdb5d8ed3cd2c633c9868db02f55ec0392019f96eb94814457aad"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.762-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "8bcebf19e0ed71bd897edc4c39596a4db4c6aacbccb51818574da1e71373e255"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.762-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "615e56f4d414d3f68a5162c6fe1a38ec0c18afca60c9454f01aa2d2faeb494f5"
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
