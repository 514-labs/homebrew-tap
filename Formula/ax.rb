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
  version "0.5.719-rp"

  on_macos do
    on_arm do
      url "https://download.514.ax/stable/0.5.719-rp/aarch64-apple-darwin/ax.tar.gz"
      sha256 "6dd50dffa6b3534551eeaf8e5b5ef9e6caa56715355e80c18534dbfdca7cf73f"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.719-rp/x86_64-apple-darwin/ax.tar.gz"
      sha256 "09ba3cb0a72b8261fe5cbb22a5efeaa4aad2b4c9154eb3846715448f6a1f273d"
    end
  end

  on_linux do
    on_arm do
      url "https://download.514.ax/stable/0.5.719-rp/aarch64-unknown-linux-gnu/ax.tar.gz"
      sha256 "6dddeae7fec10ccc1f252d0e00a81c9819166af56660f338f4c6b3149cee22fe"
    end

    on_intel do
      url "https://download.514.ax/stable/0.5.719-rp/x86_64-unknown-linux-gnu/ax.tar.gz"
      sha256 "e31971176bcc1e8e827172453cc794e34356029aafe0b9eeeaf2e15c4b3a2913"
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
